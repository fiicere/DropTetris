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
    private static let maxSpawnProb = 0.5
    private static let spIncrease = 0.001
    private static var spawnProb = minSpawnProb;
    private static var occupancyModifier = 1
    
    static func getSpawnProb() -> Double{
        update()
        println("Difficulty = \(spawnProb * occupancyModifier)")
        return spawnProb * occupancyModifier;
    }
    
    private static func update(){
        spawnProb += spIncrease
        if(spawnProb > maxSpawnProb) {spawnProb = maxSpawnProb}
    }
    
    static func resetDifficulty(){
        spawnProb = minSpawnProb
    }
}