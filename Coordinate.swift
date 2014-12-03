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
    
    public var hashValue : Int {get {return "\(x),\(y)".hashValue}}
    
    func distanceTo(coord:Coordinate) -> Int{
        return abs(x-coord.x) + abs(y - coord.y)
    }
    
    func isNull(coord:Coordinate) -> Bool{
        return coord == Coordinate.null
    }
    
}

public func + (left: Coordinate, right: Coordinate) -> Coordinate {
    return Coordinate(x: left.x + right.x, y: left.y + right.y)
}

public func - (left: Coordinate, right: Coordinate) -> Coordinate {
    return Coordinate(x: left.x - right.x, y: left.y - right.y)
}