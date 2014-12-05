//
//  Clock.swift
//  DropTetris
//
//  Created by Kevin Yue on 12/2/14.
//  Copyright (c) 2014 Kevin Yue. All rights reserved.
//

import Foundation
import SpriteKit

struct Clock{
    static var time:Double = 0
    
    static func updateTime(currentTime: CFTimeInterval){
        time =  currentTime
    }
}

class Timer{
    let startTime = Clock.time
    
    func timeElapsed() -> Double{
        return Clock.time - startTime
    }
}