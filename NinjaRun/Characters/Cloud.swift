//
//  Cloud.swift
//  NinjaRun
//
//  Created by Yauheni Bunas on 7/9/20.
//  Copyright © 2020 Yauheni Bunas. All rights reserved.
//

import SpriteKit

class Cloud: SKSpriteNode {
    var clouds: [Cloud] = []
    
    func setupClouds() {
        for i in 1...3 {
            let cloud = Cloud(imageNamed: "cloud\(i)")
            
            cloud.name = "Cloud"
            cloud.zPosition = -5
            cloud.alpha = 0.5
            cloud.setScale(2)
            
            clouds.append(cloud)
        }
    }
    
    func moveCloud(_ scene: SKScene) {
        scene.enumerateChildNodes(withName: "Cloud") { (node, _) in
            let node = node as! SKSpriteNode
            node.position.x -= 5
        }
    }
}
