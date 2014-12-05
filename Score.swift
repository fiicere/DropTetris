//
//  Score.swift
//  DropTetris
//
//  Created by Kevin Yue on 12/5/14.
//  Copyright (c) 2014 Kevin Yue. All rights reserved.
//

import Foundation
import SpriteKit

struct Score{
    private static var score:Int = 0
    private static let updateRate = 1
    
    private static var displayedScore:Double = 0
    
    static func resetScore(){
        score = 0
        displayedScore = 0
        SKLabelNode(fontNamed: Constants.font)
    }
    
    static func incrementScore(increase:Int){
        score += increase
    }
    
    static func update(){
        if(displayedScore < score){
            displayedScore += updateRate
        }
    }
    
    static func getScore() -> NSString{
        return "\(Int(displayedScore))"
    }
}