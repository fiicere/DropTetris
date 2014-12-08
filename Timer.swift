//
//  Timer.swift
//  DropTetris
//
//  Created by Kevin Yue on 12/8/14.
//  Copyright (c) 2014 Kevin Yue. All rights reserved.
//

import Foundation

class Timer{
    var startTime = CFAbsoluteTimeGetCurrent()
    
    func timeElapsed() -> Double{
        return CFAbsoluteTimeGetCurrent() - startTime
    }
}