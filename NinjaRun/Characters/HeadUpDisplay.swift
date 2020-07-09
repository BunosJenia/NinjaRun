//
//  HeadUpDisplay.swift
//  NinjaRun
//
//  Created by Yauheni Bunas on 7/9/20.
//  Copyright © 2020 Yauheni Bunas. All rights reserved.
//

import SpriteKit

class HeadUpDisplay: SKNode {
    var scoreLabel: SKLabelNode!
    var highscoreLabel: SKLabelNode!
    
    override init() {
        super.init()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func addLabel(fontSize: CGFloat, name: String, text: String) {
        guard let scene = scene as? GameScene else { return }
        
        let position = CGPoint(x: scene.playableRect.width / 2, y: scene.playableRect.height / 2 + 300)
        
        addLabel(name, text: text, fontSize: fontSize, position: position)
    }
    
    func addLabel(_ name: String, text: String, fontSize: CGFloat, position: CGPoint) {
        let label = SKLabelNode()
        
        label.fontName = fontNamed
        label.name = name
        label.text = text
        label.position = position
        label.fontSize = fontSize
        label.zPosition = 5
        
        addChild(label)
    }
    
    func setupScoreLabel(_ score: Int) {
        guard let scene = scene as? GameScene else { return }
        
        let position = CGPoint(x: 50, y: scene.playableRect.maxY - 40)
        
        addLabel(HeadUpDisplaySettings.score, text: "Score: \(score)", fontSize: 100, position: position)
        
        scoreLabel = childNode(withName: HeadUpDisplaySettings.score) as? SKLabelNode
        
        scoreLabel.horizontalAlignmentMode = .left
        scoreLabel.verticalAlignmentMode = .top
    }
    
    func setupHighscoreLabel(_ highscore: Int) {
        guard let scene = scene as? GameScene else { return }
        
        let position = CGPoint(x: scene.playableRect.maxX - 50, y: scene.playableRect.maxY - 40)
        
        addLabel(HeadUpDisplaySettings.highscore, text: "Highscore: \(highscore)", fontSize: 100, position: position)
        
        highscoreLabel = childNode(withName: HeadUpDisplaySettings.highscore) as? SKLabelNode
        
        highscoreLabel.horizontalAlignmentMode = .right
        highscoreLabel.verticalAlignmentMode = .top
    }
    
    func updateScore(_ score: Int) {
        scoreLabel = childNode(withName: HeadUpDisplaySettings.score) as? SKLabelNode
        
        scoreLabel.text = "Score: \(score)"
    }
    
    func setupGameState(from: GameState, to: GameState) {
        clearUI(gameState: from)
        updateUI(gameState: to)
    }
    
    func updateUI(gameState: GameState) {
        switch gameState {
        case .start:
            addLabel(fontSize: 250, name: HeadUpDisplaySettings.tapToStart, text: HeadUpDisplaySettings.tapToStart)
        case .dead:
            addLabel(fontSize: 250, name: HeadUpDisplaySettings.gameOver, text: HeadUpDisplaySettings.gameOver)
        default: break
        }
    }
    
    func clearUI(gameState: GameState) {
        switch gameState {
        case .start:
            self.childNode(withName: HeadUpDisplaySettings.tapToStart)?.removeFromParent()
        case .dead:
            self.childNode(withName: HeadUpDisplaySettings.gameOver)?.removeFromParent()
        default: break
        }
    }
}
