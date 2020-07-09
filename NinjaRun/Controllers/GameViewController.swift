//
//  GameViewController.swift
//  NinjaRun
//
//  Created by Yauheni Bunas on 7/8/20.
//  Copyright © 2020 Yauheni Bunas. All rights reserved.
//

import UIKit
import SpriteKit
import GameplayKit

class GameViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let scene = GameScene(size: CGSize(width: 2048.0, height: 1536.0))
        scene.scaleMode = .aspectFill
        
        let skView = view as! SKView
//        skView.showsFPS = true
//        skView.showsNodeCount = true
//        skView.showsPhysics = true
//        skView.ignoresSiblingOrder = true
        skView.presentScene(scene)
    }

    override var prefersStatusBarHidden: Bool {
        return true
    }
}
