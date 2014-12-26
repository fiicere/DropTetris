//
//  Difficulty.swift
//  DropTetris
//
//  Created by Kevin Yue on 12/7/14.
//  Copyright (c) 2014 Kevin Yue. All rights reserved.
//

import Foundation

struct Difficulty{
    
    private static let minSpawnProb = 0.3
    private static let maxSpawnProb = 0.55
    private static let spIncrease = 0.001
    private static var spawnProb = minSpawnProb;
    //Runs from -omScale  to + omScale
    private static let omScale = 0.1
    private static var occupancyModifier = omScale
    
    private static var timer = Timer()
    
    static func getSpawnProb() -> Double{
        return spawnProb + occupancyModifier;
    }
    
    /**
    OCCUPANCY MUST BE BETWEEN 0 AND 1
    */
    static func update(occupancy:Double){
        assert(occupancy <= 1, "ERROR: Cannot have an occupancy > 1")
        assert(occupancy >= 0, "ERROR: Cannot have an occupancy < 0")

        occupancyModifier = (occupancy - 0.5) * -2 * omScale
//        spawnProb = minSpawnProb + spIncrease * timer.timeElapsed()
//        if(spawnProb > maxSpawnProb) {spawnProb = maxSpawnProb}
    }
    
    static func increaseSpawnProb(){
        spawnProb += spIncrease
        if(spawnProb > maxSpawnProb) {spawnProb = maxSpawnProb}
        
        println("Spawn Probability = \(spawnProb)")
    }
    
    static func resetDifficulty(){
        timer = Timer()
        spawnProb = minSpawnProb
    }
}