//
//  Direction.swift
//  DropTetris
//
//  Created by Kevin Yue on 1/6/15.
//  Copyright (c) 2015 Kevin Yue. All rights reserved.
//

import Foundation

enum Direction : String{
    case UP="UP", DOWN = "DOWN", LEFT="LEFT", RIGHT="RIGHT", NONE="NONE"
    static let all : Array<Direction> = [UP, DOWN, LEFT, RIGHT]
    
    func opposite() -> Direction{
        switch self{
        case UP:
            return DOWN
        case DOWN:
            return UP
        case LEFT:
            return RIGHT
        case RIGHT:
            return LEFT
        default:
            return NONE
        }
    }
}

enum Rotation : String{
    case CW = "CW", CCW = "CCW", NONE = "NONE"
}

enum Transformation : String{
    case UP="UP", DOWN = "DOWN", LEFT="LEFT", RIGHT="RIGHT", CW = "CW", CCW = "CCW", NONE="NONE"
    
    static let all : Array<Transformation> = [UP, DOWN, LEFT, RIGHT, CW, CCW]
    
    func opposite() -> Transformation{
        switch self{
        case UP:
            return DOWN
        case DOWN:
            return UP
        case LEFT:
            return RIGHT
        case RIGHT:
            return LEFT
        case CW:
            return CCW
        case CCW:
            return CW
        default:
            return NONE
        }
    }
}