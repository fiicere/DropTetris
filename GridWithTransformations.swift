//
//  GridWithTransformations.swift
//  DropTetris
//
//  Created by Kevin Yue on 12/15/14.
//  Copyright (c) 2014 Kevin Yue. All rights reserved.
//

import Foundation


enum Rotation{
    case CW, CCW, NONE
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
        for sq:GridSq in occupied(){
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
}
