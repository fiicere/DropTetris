//
//  Indicator.swift
//  DropTetris
//
//  Created by Kevin Yue on 12/29/14.
//  Copyright (c) 2014 Kevin Yue. All rights reserved.
//

import Foundation
import SpriteKit

class Indicator:SKSpriteNode{
    let marginPixels = CGSize(width: 2, height: 2)
    let center = Coordinate.zero
    
    var coordDict:Dictionary<Coordinate, Boolean> = Dictionary<Coordinate, Boolean>()
    
//    func move(d:Direction){
//        if(mainGrid.coordIsInGrid(center.adjacent(d))){
//            center = center.adjacent(d)
//        }
//    }
    
    
}