//
//  GridWithTransformations.swift
//  DropTetris
//
//  Created by Kevin Yue on 12/15/14.
//  Copyright (c) 2014 Kevin Yue. All rights reserved.
//

import Foundation


enum Rotation : String{
    case CW = "CW", CCW = "CCW", NONE = "NONE"
}

class GridWithTransformations : Grid{
    
    override init(d:GridDimension){
        super.init(d: d)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func center(){
        for d:Direction in Direction.all{
            if(canTranslate(d) && !canTranslate(d.opposite())){
                translate(d)
            }
        }
    }
    
    private func safeTranslate(d: Direction){
        if (canTranslate(d)){translate(d)}
    }
    
    private func translate(d: Direction){
        var a = occupied()  //IMPORTANT: do NOT modify a list while iterating through it ;)
        for sq:GridSq in a{
            var piece = sq.contains!
            clearSq(sq.coord)
            addPiece(piece, coord:sq.coord.adjacent(d))
        }
    }
    
    private func canTranslate(d : Direction) -> Bool{
        for sq:GridSq in occupied(){
            if(!coordIsInGrid(sq.coord.adjacent(d))){
                return false
            }
        }
        return true
    }
    
    
    func rotate(r:Rotation){
        switch r{
        case .CW:
            for sq:GridSq in sqDict.values{
                sq.coord = Coordinate(x: sq.coord.y, y: -sq.coord.x)
            }
        case .CCW:
            for sq:GridSq in sqDict.values{
                sq.coord = Coordinate(x: -sq.coord.y, y: sq.coord.x)
            }
        default:
            println("ERROR: Rotation with type 'NONE'")
        }
        
        updateGridSqs()
    }
}
