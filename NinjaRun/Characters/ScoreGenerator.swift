//
//  ScoreGenerator.swift
//  NinjaRun
//
//  Created by Yauheni Bunas on 7/9/20.
//  Copyright © 2020 Yauheni Bunas. All rights reserved.
//

import Foundation

class ScoreGenerator {
    static let sharedInstance = ScoreGenerator()
    
    private init() {}
    
    static let keyHighscore = "keyHighscore"
    
    func setHighscore(_ highscore: Int) {
        UserDefaults.standard.set(highscore, forKey: ScoreGenerator.keyHighscore)
    }
    
    func getHighscore() -> Int {
        return UserDefaults.standard.integer(forKey: ScoreGenerator.keyHighscore)
    }
}
