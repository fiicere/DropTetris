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

    var hashValue : Int
    
    init(loc:CGPoint, hash:Int){
        startTime = CFAbsoluteTimeGetCurrent()
        startLoc = loc
        currentLoc = loc
        hashValue = hash
    }
    
    func movedTo(loc:CGPoint){
        currentLoc = loc
    }
}

struct FinishedTouch : Hashable {
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
    
    func timeElapsed() -> Double{
        return CFAbsoluteTimeGetCurrent() - endTime
    }

}

//!!!!!!!!!!!!!!!!!!NOTE TO SELF:Create a Set data type for activeTouches and finishedTouches with a pop() method!!!!!!!!!
//!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!

struct TouchManager{
    private static var activeTouches = Array<ActiveTouch>()
    private static var finishedTouches = Array<FinishedTouch>()
    
    static func touchBegan(loc:CGPoint, hash:Int){
        var newActiveTouch = ActiveTouch(loc: loc, hash: hash)
        if(!contains(activeTouches, newActiveTouch)){activeTouches.append(newActiveTouch)}
        else{println("ERROR: Duplicate touch \(newActiveTouch.hashValue)")}
    }
    
    static func touchMoved(loc:CGPoint, hash:Int){
        for t:ActiveTouch in activeTouches{
            if(t.hashValue == hash){t.movedTo(loc)}
        }
    }
    
    static func touchEnded(touch:ActiveTouch){
        if(contains(activeTouches, touch)){
            removeTouch(touch)
            addFinishedTouch(FinishedTouch(touch: touch))
            pruneOldFinishedTouches()
        }
        else{
            println("ERROR: There is no touch \(touch.hashValue)")
        }
    }
    
    private static func removeTouch(touch:ActiveTouch){
        var i = 0;
        while(i<activeTouches.count){
            if(activeTouches[i] == touch){activeTouches.removeAtIndex(i)}
            else{i++}
        }
    }
    
    private static func addFinishedTouch(touch:FinishedTouch){
        if(!contains(finishedTouches, touch)){finishedTouches.append(touch)}
    }
    
    private static func pruneOldFinishedTouches(){
        var i=0
        while(i<finishedTouches.count){
            if(finishedTouches[i].timeElapsed() > TouchConstants.finishedTouchDuration){finishedTouches.removeAtIndex(i)}
            else{i++}
        }
    }
}
