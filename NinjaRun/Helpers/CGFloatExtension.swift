//
//  CGFloatExtension.swift
//  NinjaRun
//
//  Created by Yauheni Bunas on 7/9/20.
//  Copyright © 2020 Yauheni Bunas. All rights reserved.
//

import CoreGraphics

extension CGFloat {
    static func random() -> CGFloat {
        return CGFloat(Float(arc4random()) / Float(0xFFFFFFFF))
    }
    
    static func random(min: CGFloat, max: CGFloat) -> CGFloat {
        assert(min < max)
        return CGFloat.random() * (max - min) + min
    }
}
