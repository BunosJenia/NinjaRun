//
//  GameScene.swift
//  NinjaRun
//
//  Created by Yauheni Bunas on 7/8/20.
//  Copyright © 2020 Yauheni Bunas. All rights reserved.
//

import SpriteKit
import GameplayKit

class GameScene: SKScene {
    var groundNode = Ground()
    var playerNode = Player()
    var cloud = Cloud()
    var hud = HeadUpDisplay()
    
    var moveSpeed: CGFloat = 8.0
    
    var wallTimer: Timer?
    var cloudTimer: Timer?
    
    var score = 0
    
    var playableRect: CGRect {
        let ratio: CGFloat
        switch UIScreen.main.nativeBounds.height {
        case 2688, 1792, 2436:
            ratio = 2.16
        default:
            ratio = 16 / 9
        }
        
        let playableHeight = size.width / ratio
        let playableMargin = (size.height - playableHeight) / 2
        
        return CGRect(x: 0, y: playableMargin, width: size.width, height: playableHeight)
    }
    
    var gameState: GameState = .initial {
        didSet {
            hud.setupGameState(from: oldValue, to: gameState)
        }
    }
    
    override func didMove(to view: SKView) {
        backgroundColor = UIColor(red: 194/255, green: 234/255, blue: 253/255, alpha: 1.0)
        
        if gameState == .initial {
            setupNodes()
            setupPhysics()
            
            gameState = .start
        }
        
//        let shape = SKShapeNode(rect: playbleRect)
//        shape.lineWidth = 4
//        shape.strokeColor = .red
//
//        self.addChild(shape)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        
        guard let touch = touches.first else { return }
        
        let node = atPoint(touch.location(in: self))
        
        if node.name == HeadUpDisplaySettings.tapToStart {
            gameState = .play
            isPaused = false
            
            setupTimer()
        } else if node.name == HeadUpDisplaySettings.gameOver {
            let scene = GameScene(size: size)
            
            scene.scaleMode = scaleMode
            view!.presentScene(scene, transition: .fade(withDuration: 0.5))
        } else {
            playerNode.setupMoveUpDown()
        }
    }
    
    override func update(_ currentTime: TimeInterval) {
        if gameState != .play {
            isPaused = true
            
            return
        }
        
        groundNode.moveGround(self)
        moveWall()
        cloud.moveCloud(self)
    }
}

extension GameScene {
    func setupNodes() {
        groundNode.setupGround(self)
        playerNode.setupPlayer(groundNode, scene: self)
        cloud.setupClouds()
        setupHUD()
    }
    
    func setupPhysics() {
        physicsWorld.contactDelegate = self
    }
    
    func setupTimer() {
        var wallRandoms = CGFloat.random(in: 1...2)
        
        wallTimer = Timer.scheduledTimer(timeInterval: TimeInterval(wallRandoms), target: self, selector: #selector(spawnWalls), userInfo: nil, repeats: true)
        
        
        let cloudRandoms = CGFloat.random(in: 3...7)
        cloudTimer = Timer.scheduledTimer(timeInterval: TimeInterval(cloudRandoms), target: self, selector: #selector(spawnClouds), userInfo: nil, repeats: true)
    }
    
    @objc func spawnWalls() {
        let scale: CGFloat = Int(arc4random_uniform(UInt32(2))) == 0 ? -1 : 1
        
        let wall = SKSpriteNode(imageNamed: "block").copy() as! SKSpriteNode
        let score = SKSpriteNode(imageNamed: "coin").copy() as! SKSpriteNode
        //let score = SKSpriteNode(texture: nil, color: .red, size: CGSize(width: 50, height: 50)).copy() as! SKSpriteNode
        
        let positionYValue: CGFloat = wall.frame.height + groundNode.frame.height
        let wallPositionY = frame.height / 2 + (positionYValue/2 * scale)
        let scorePositionY = frame.height / 2 + (positionYValue/2 * (-scale))
        let poxitionX = size.width + wall.frame.width
        
        // Wall
        wall.name = "Block"
        wall.zPosition = 2
        wall.position = CGPoint(x: poxitionX, y: wallPositionY)
        wall.physicsBody = SKPhysicsBody(rectangleOf: wall.size)
        wall.physicsBody!.affectedByGravity = false
        wall.physicsBody!.isDynamic = false
        wall.physicsBody!.categoryBitMask = PhysicsCategory.Wall
        
        // Score
        score.name = "Score"
        score.size = CGSize(width: 50, height: 50)
        score.zPosition = 2
        score.position = CGPoint(x: poxitionX, y: scorePositionY)
        score.physicsBody = SKPhysicsBody(rectangleOf: score.size)
        score.physicsBody!.affectedByGravity = false
        score.physicsBody!.isDynamic = false
        score.physicsBody!.categoryBitMask = PhysicsCategory.Score
        
        self.addChild(wall)
        self.addChild(score)
        
        wall.run(.sequence([.wait(forDuration: 8), .removeFromParent()]))
        score.run(.sequence([.wait(forDuration: 8), .removeFromParent()]))
    }
    
    func moveWall() {
        enumerateChildNodes(withName: "Block") { (node, _) in
            let node = node as! SKSpriteNode
            node.position.x -= self.moveSpeed
        }
        
        enumerateChildNodes(withName: "Score") { (node, _) in
            let node = node as! SKSpriteNode
            node.position.x -= self.moveSpeed
        }
    }
    
    @objc func spawnClouds() {
        let index = Int(arc4random_uniform(UInt32(cloud.clouds.count - 1)))
        let cloud = self.cloud.clouds[index].copy() as! Cloud
        let randomY = CGFloat.random(in: -cloud.frame.height...cloud.frame.height * 2)
        
        cloud.position = CGPoint(x: frame.width + cloud.frame.width, y: randomY)
        
        self.addChild(cloud)
        
        cloud.run(.sequence([.wait(forDuration: 15), .removeFromParent()]))
    }
    
    func setupHUD() {
        self.addChild(hud)
        
        hud.setupScoreLabel(score)
        hud.setupHighscoreLabel(ScoreGenerator.sharedInstance.getHighscore())
    }
    
    func gameOver() {
        playerNode.removeFromParent()
        wallTimer?.invalidate()
        cloudTimer?.invalidate()
        
        gameState = .dead
        isPaused = true
        
        let highscore = ScoreGenerator.sharedInstance.getHighscore()
        
        if score > highscore {
            ScoreGenerator.sharedInstance.setHighscore(score)
        }
    }
    
    func increaseSpeed() {
        if score % 5 == 0 {
            moveSpeed += 2
        }
    }
}

extension GameScene: SKPhysicsContactDelegate {
    func didBegin(_ contact: SKPhysicsContact) {
        let notPlayerBody = contact.bodyA.categoryBitMask == PhysicsCategory.Player ? contact.bodyB : contact.bodyA
        
        switch notPlayerBody.categoryBitMask {
        case PhysicsCategory.Wall:
            gameOver()
        case PhysicsCategory.Score:
            if let node = notPlayerBody.node {
                score += 1
                
                hud.updateScore(score)
                
                increaseSpeed()
                node.removeFromParent()
            }
        default:
            break
        }
    }
}
