//
//  Indicator.swift
//  DropTetris
//
//  Created by Kevin Yue on 1/6/15.
//  Copyright (c) 2015 Kevin Yue. All rights reserved.
//

import Foundation

class Indicator{
    private var center:Coordinate = Coordinate.zero
    private var contents:Array<Coordinate>
    
    convenience init(occupied:Array<GridSq>){
        self.init(occupied: occupied.map({$0.coord}))
    }
    
    init(occupied:Array<Coordinate>){
        contents = occupied
        debugContents()
    }
    
    func moveTo(coord:Coordinate){
        center = coord
    }
    
    func moveInDirection(d:Direction){
        moveTo(center.adjacent(d))
    }
    
    func getContents() -> Array<Coordinate>{
        return contents.map{$0 + self.center}
    }
    
    func indicatorInBounds(xMin:Int, xMax:Int, yMin:Int, yMax:Int)->Bool{
        for coord:Coordinate in getContents(){
            if(coord.x < xMin){return false}
            if(coord.x > xMax){return false}
            if(coord.y < yMin){return false}
            if(coord.y > yMax){return false}
        }
        return true
    }
    
    private func debugContents(){
        println("\nSTART INDICATOR DEBUG:")
        for c:Coordinate in contents{
            println("Indicator contains (\(c.x),\(c.y))")
        }
    }
}