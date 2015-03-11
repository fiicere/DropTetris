//
//  Touch.swift
//  DropTetris
//
//  Created by Kevin Yue on 3/8/15.
//  Copyright (c) 2015 Kevin Yue. All rights reserved.
//

import Foundation
import SpriteKit

func == (left: Touch, right: Touch) -> Bool {
    return left.hashValue == right.hashValue
}

public struct PointMark {
    let loc:CGPoint
    let timeStamp:Int
    
    init(point:CGPoint){
        loc = point
        timeStamp = Int(CFAbsoluteTimeGetCurrent())
    }
}

class Touch : Hashable{
    var history:[PointMark] = Array()
    var hashValue : Int
    
    init(loc:CGPoint, hash:Int){
        hashValue = hash
        history.append(PointMark(point: loc))
    }
    
    func movedTo(loc:CGPoint){
        history.append(PointMark(point:loc))
    }
    
    func durationInSeconds() -> Int{
        return end().timeStamp - start().timeStamp
    }
    
    func displacement()-> CGVector{
        return (start().loc - end().loc).toVector()
    }
    
    func start()->PointMark{
        return history[history.startIndex]
    }
    
    func end()->PointMark{
        return history[history.endIndex - 1]
    }
    
    func avgLoc() -> CGPoint{
        var avg = CGPoint.zeroPoint
        for p:PointMark in history{
            avg += p.loc
        }
        return avg / CGPoint(x: history.count, y: history.count)
    }

}

struct TouchManager{
    static var active = Array<Touch>()
    static var finished = Array<Touch>()
    static var gesture = Gesture.None()
    
    static func touchBegan(hash:Int, loc:CGPoint){
        active.append(Touch(loc: loc, hash: hash))
    }
    
    static func touchMoved(hash:Int, loc:CGPoint){
        if (hasActiveTouch(hash)){getActiveTouch(hash).movedTo(loc)}
        else{fatalError("ERROR: No Active Touch: \(hash)")} // REMOVE AFTER TESTING
    }
    
    static func touchEnded(hash:Int){
        if (hasActiveTouch(hash)){
            finished.append(getActiveTouch(hash))
            removeActiveTouch(hash)
        }
        convertFinishedToGesture()
    }
    
    static private func hasGesture() -> Bool{
        return !gesture.isNone()
    }
    
    static func popGesture() -> Gesture{
        var g = gesture
        gesture = Gesture.None()
        return g
    }
    
    static private func convertFinishedToGesture(){
        //If there are no active touches, convert finished to gestures
        if (active.isEmpty){
            if(finished.count > 2 || finished.count < 1){print("\(finished.count) touches not permitted; only 1 or 2")}
            else if(finished.count == 1){gesture = parseTouch(finished[0])}
            else if(finished.count == 2){gesture = parseDuoTouch(finished[0], t2: finished[1])}
            
            finished = Array()
        }
        //If not, then one of the multi-touch touches isn't finished yet
        //Just wait for it to finish
    }
    
    static private func parseTouch(t:Touch) -> Gesture{
        var g = Gesture.None()
        
        // Check for Swipe
        if(t.durationInSeconds() < TouchConstants.swipeMaxDuration && t.displacement().magnitude() > TouchConstants.swipeMinRadius)
            {g.type = GestureType.SWIPE}
        else{g.type = GestureType.CLICK}
        
        // Get Location
        g.loc = t.avgLoc()
        
        // Get Direction
        if(abs(t.displacement().dx) >= abs(t.displacement().dy)){
            if(t.displacement().dx > 0){g.transformation = Transformation.RIGHT}
            if(t.displacement().dx <= 0){g.transformation = Transformation.LEFT}
        }
        else if(abs(t.displacement().dx) < abs(t.displacement().dy)){
            if(t.displacement().dy > 0){g.transformation = Transformation.UP}
            if(t.displacement().dy <= 0){g.transformation = Transformation.DOWN}
        }
        
        return g
    }
    
    static private func parseDuoTouch(t1:Touch, t2: Touch) -> Gesture{
        var g = Gesture.None()
        g.type = GestureType.ROTATE
        
        var startAngle = getAngle(t1.start().loc, t2.start().loc)
        var endAngle = getAngle(t1.end().loc, t2.end().loc)
        var changeInAngle = mod(endAngle - startAngle, 2 * M_PI)
        
        if(changeInAngle > M_PI){g.transformation = Transformation.CW}
        else{g.transformation = Transformation.CCW}
        
        return g
    }
    
    static private func removeActiveTouch(hash:Int){
        var i=0
        while i < active.count{
            if active[i].hashValue == hash{active.removeAtIndex(i)}
            else{i+=1}
        }
    }
    
    static private func getActiveTouch(hash:Int) -> Touch{
        for t:Touch in active{
            if t.hashValue == hash {return t}
        }
        fatalError("ERROR: No Active Touch: \(hash)")
    }
    
    static private func hasActiveTouch(hash:Int) -> Bool{
        for t:Touch in active{
            if t.hashValue == hash {return true}
        }
        return false
    }
}

enum GestureType{
    case SWIPE, ROTATE, CLICK, NONE
}


struct Gesture{
    var type:GestureType
    var loc : CGPoint
    var transformation : Transformation
    
    static func None() -> Gesture{
        return Gesture(type: GestureType.NONE, loc: CGPoint.zeroPoint, transformation: Transformation.NONE)
    }
    
    func isNone() -> Bool{
        return type == GestureType.NONE
    }
}
































