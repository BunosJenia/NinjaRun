//
//  Player.swift
//  NinjaRun
//
//  Created by Yauheni Bunas on 7/8/20.
//  Copyright © 2020 Yauheni Bunas. All rights reserved.
//

import SpriteKit

class Player: SKSpriteNode {
    var isMoveDown = false
    
    init() {
        let texture = SKTexture(imageNamed: "player1")
        super.init(texture: texture, color: .clear, size: texture.size())
        name = "Player"
        zPosition = 1.0
        setScale(0.75)
        
        physicsBody = SKPhysicsBody(rectangleOf: size)
        physicsBody!.affectedByGravity = false
        physicsBody!.categoryBitMask = PhysicsCategory.Player
        physicsBody!.collisionBitMask = PhysicsCategory.Wall
        physicsBody!.contactTestBitMask = PhysicsCategory.Wall | PhysicsCategory.Score
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension Player {
    func setupPlayer(_ ground: Ground, scene: SKScene) {
        position = CGPoint(x: scene.frame.width / 2 - 100.0, y: (scene.frame.height + ground.frame.height + frame.height) / 2)
        
        scene.addChild(self)
        
        setupAnimation()
    }
    
    func setupAnimation() {
        var textures: [SKTexture] = []
        
        for i in 1...2 {
            textures.append(SKTexture(imageNamed: "player\(i)"))
        }
        
        run(.repeatForever(.animate(with: textures, timePerFrame: 0.1)))
    }
    
    func setupMoveUpDown() {
        isMoveDown = !isMoveDown
        
        let scale: CGFloat = isMoveDown ? -0.75 : 0.75
        
        let flipY = SKAction.scaleY(to: scale, duration: 0.1)
        let moveBy = SKAction.moveBy(x: 0, y: scale * (frame.width * 2.6), duration: 0.1)
        
        run(flipY)
        run(moveBy)
    }
}
