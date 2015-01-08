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

enum TouchType{
    case DRAG, TAP, SWIPE, NONE
}

struct FinishedTouch : Hashable {
    private var startTime:CFAbsoluteTime
    private var startLoc:CGPoint
    private var endTime:CFAbsoluteTime
    private var endLoc:CGPoint
    var type:TouchType = TouchType.NONE
    
    var hashValue:Int
    
    init(touch:ActiveTouch){
        startTime = touch.startTime
        startLoc = touch.startLoc
        endTime = CFAbsoluteTimeGetCurrent()
        endLoc = touch.currentLoc
        hashValue = touch.hashValue
        
        type = getType()
    }
    
    func timeElapsed() -> Double{
        return CFAbsoluteTimeGetCurrent() - endTime
    }
    
    func duration()->Double{
        return endTime - startTime
    }
    
    func displacement() -> CGVector{
        return (endLoc - startLoc).toVector()
    }

    func direction()->Direction{
        if(abs(displacement().dx) > abs(displacement().dy)){
            if(displacement().dx > 0){return Direction.RIGHT}
            else{return Direction.LEFT}
        }
        else{
            if(displacement().dy > 0){return Direction.UP}
            else{return Direction.DOWN}
        }
    }
    
    func getType()->TouchType{
        if (displacement().magnitude() < TouchConstants.swipeMinRadius) {return TouchType.TAP}
        if (duration() < TouchConstants.tapMaxDuration){return TouchType.TAP}
        if (duration() < TouchConstants.swipeMaxDuration){return TouchType.SWIPE}
        else{return TouchType.DRAG}
    }

}


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
    
    static func touchEnded(hash:Int) -> FinishedTouch{
        var ft = FinishedTouch(touch:getActiveTouch(hash)!)
        addFinishedTouch(ft)
        pruneOldFinishedTouches()
        return ft
    }
    
    private static func getActiveTouch(hash:Int) -> ActiveTouch?{
        for touch:ActiveTouch in activeTouches{
            if(touch.hashValue == hash){return touch}
        }
        println("ERROR: There is no touch \(hash)")
        return nil
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
