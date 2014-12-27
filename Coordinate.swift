 //
//  Coordinate.swift
//  DropTetris
//
//  Created by Kevin Yue on 11/21/14.
//  Copyright (c) 2014 Kevin Yue. All rights reserved.
//

import Foundation

public func == (left: Coordinate, right: Coordinate) -> Bool {
    return left.hashValue == right.hashValue
}

/**
    Taxicab Geometry
*/
public struct Coordinate : Hashable{
    let x : Int
    let y : Int
    
    static var null:Coordinate = Coordinate(x: Int.min, y: Int.min)
    static let unitX = Coordinate(x: 1, y: 0)
    static let unitY = Coordinate(x: 0, y: 1)
    
    public var hashValue : Int {get {return "\(x),\(y)".hashValue}}
    
    func distanceTo(coord:Coordinate) -> Int{
        return abs(x-coord.x) + abs(y - coord.y)
    }
    
    func isNull(coord:Coordinate) -> Bool{
        return coord == Coordinate.null
    }
    
    func adjacent(d:Direction) -> Coordinate{
        switch d{
        case .UP:
            return self + Coordinate.unitY
        case .DOWN:
            return self - Coordinate.unitY
        case .RIGHT:
            return self + Coordinate.unitX
        case .LEFT:
            return self - Coordinate.unitX
        default:
            println("ERROR: Invalid direction")
            return self
        }
    }
    
}
 
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

public func + (left: Coordinate, right: Coordinate) -> Coordinate {
    return Coordinate(x: left.x + right.x, y: left.y + right.y)
}

public func - (left: Coordinate, right: Coordinate) -> Coordinate {
    return Coordinate(x: left.x - right.x, y: left.y - right.y)
}