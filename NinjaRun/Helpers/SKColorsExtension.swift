//
//  SKColorsExtension.swift
//  NinjaRun
//
//  Created by Yauheni Bunas on 7/8/20.
//  Copyright © 2020 Yauheni Bunas. All rights reserved.
//

import SpriteKit

extension  SKColor {
    convenience init(hex: Int, alpha: CGFloat = 1.0) {
        let red = CGFloat((hex & 0xFF0000) >> 16) / 255.0
        let green = CGFloat((hex & 0xFF00) >> 8) / 255.0
        let blue = CGFloat((hex & 0xFF)) / 255.0
        self.init(red: red, green: green, blue: blue, alpha: alpha)
    }
}
