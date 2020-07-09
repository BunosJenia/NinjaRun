//
//  Types.swift
//  NinjaRun
//
//  Created by Yauheni Bunas on 7/9/20.
//  Copyright © 2020 Yauheni Bunas. All rights reserved.
//

import Foundation

struct PhysicsCategory {
    static let Player: UInt32 = 1
    static let Wall: UInt32 = 2
    static let Score: UInt32 = 4
}

public let fontNamed = "All The Roll - Personal Use"

enum GameState: Int {
    case initial = 0, start, play, dead
}

enum HeadUpDisplaySettings {
    static let score = "Score"
    static let highscore = "Highscore"
    static let gameOver = "Game Over"
    static let tapToStart = "Tap To Start"
}
