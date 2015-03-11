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
        return history[history.endIndex]
    }

}

class TouchManager{
    var active:[Touch]
    var finished:[Touch]
    var gesture:Gesture
    
    init(){
        active = Array()
        finished = Array()
        gesture = Gesture.None() // TODO: Should be equal to the default nil gesture
    }
    
    func touchBegan(hash:Int, loc:CGPoint){
        active.append(Touch(loc: loc, hash: hash))
    }
    
    func touchMoved(hash:Int, loc:CGPoint){
        if (hasActiveTouch(hash)){getActiveTouch(hash).movedTo(loc)}
    }
    
    func touchEnded(hash:Int){
        if (hasActiveTouch(hash)){
            finished.append(getActiveTouch(hash))
            removeActiveTouch(hash)
        }
        convertFinishedToGesture()
    }
    
    func popGesture()->Gesture{
        var g = gesture
        //TODO: Gesture = default nil gesture
        return g
    }
    
    private func convertFinishedToGesture(){
        if (active.isEmpty){
            // Convert finished to a gesture
            // gesture = finishedGesture
            finished = Array()
        }
        //If not, then one of the multi-touch touches isn't finished yet
    }
    
    private func removeActiveTouch(hash:Int){
        var i=0
        while i < active.count{
            if active[i].hashValue == hash{active.removeAtIndex(i)}
            else{i+=1}
        }
    }
    
    private func getActiveTouch(hash:Int) -> Touch{
        for t:Touch in active{
            if t.hashValue == hash {return t}
        }
        fatalError("ERROR: No Active Touch: \(hash)")
    }
    
    private func hasActiveTouch(hash:Int) -> Bool{
        for t:Touch in active{
            if t.hashValue == hash {return true}
        }
        return false
    }
    
    
    
    
}

struct Gesture{
    var loc : CGPoint
    var transformation : Transformation
    
    static func None() -> Gesture{
        return Gesture(loc: CGPoint.nonePoint, transformation: Transformation.NONE)
    }
    
    func isNone() -> Bool{
        return (transformation == Transformation.NONE && loc == CGPoint.nonePoint)
    }
}
































