//
//  GridDimensions.swift
//  DropTetris
//
//  Created by Kevin Yue on 11/20/14.
//  Copyright (c) 2014 Kevin Yue. All rights reserved.
//

import Foundation
import SpriteKit

struct GridDimension{
    var numRows:Int
    var numCols:Int
    var gridSize:CGSize
    var origin:CGPoint
 
    func rowMax()-> Int{
        return Int(numRows / 2)
    }
    
    func rowMin()-> Int{
        return -rowMax()
    }
    
    func colMax()-> Int{
        return Int(numCols / 2)
    }
    
    func colMin()-> Int{
        return -colMax()
    }
}