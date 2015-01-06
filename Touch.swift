//
//  Touch.swift
//  DropTetris
//
//  Created by Kevin Yue on 1/6/15.
//  Copyright (c) 2015 Kevin Yue. All rights reserved.
//

import Foundation
import SpriteKit

func == (left: ActiveTouch, right: ActiveTouch) -> Bool {
    return left.hashValue == right.hashValue
}

func == (left: FinishedTouch, right: FinishedTouch) -> Bool {
    return left.hashValue == right.hashValue
}

class ActiveTouch : Hashable{
    private var startTime:CFAbsoluteTime
    private var startLoc:CGPoint
    private var currentLoc:CGPoint

    var hashValue : Int {get {return "\(startTime),\(startLoc)".hashValue}}
    
    init(loc:CGPoint){
        startTime = CFAbsoluteTimeGetCurrent()
        startLoc = loc
        currentLoc = loc
    }
    
    func movedTo(loc:CGPoint){
        currentLoc = loc
    }
}

struct FinishedTouch : Hashable{
    private var startTime:CFAbsoluteTime
    private var startLoc:CGPoint
    private var endTime:CFAbsoluteTime
    private var endLoc:CGPoint
    
    var hashValue : Int {get {return "\(startTime),\(startLoc)".hashValue}}
    
    init(touch:ActiveTouch){
        startTime = touch.startTime
        startLoc = touch.startLoc
        endTime = CFAbsoluteTimeGetCurrent()
        endLoc = touch.currentLoc
    }

}

struct TouchManager{
    static var activeTouches = Array<ActiveTouch>()
    static var finishedTouches = Array<FinishedTouch>()
}
