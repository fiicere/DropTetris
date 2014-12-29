//
//  SmallGrid.swift
//  DropTetris
//
//  Created by Kevin Yue on 12/1/14.
//  Copyright (c) 2014 Kevin Yue. All rights reserved.
//

import Foundation
import SpriteKit

class SmallGrid: GridWithTransformations {
    let myGridDims:GridDimension
    
    init(marginRatio:CGFloat){
        
        let subGridSize = Layout.GridSqSize * Rules.subGridN
        
        myGridDims = GridDimension(numRows: Rules.subGridN, numCols: Rules.subGridN,
            gridSize: subGridSize,
            origin: CGPoint.topRight - Layout.screenMarginSize.toVector() - subGridSize.toVector().half());
        
        super.init(d: myGridDims)
        
        populate()
    }
    
    func resetPieces(){
        clearAllPieces()
        populate()
    }
    
    func populate(){
        var spawnProb = Difficulty.getSpawnProb()
        for sq : GridSq in sqDict.values{
            if(self.random(spawnProb)){
                sq.addPiece()
            }
        }
        if(piecesInGrid() == 0){
            populate()
        }
        center()
    }
    
    func clearAllPieces(){
        for sq : GridSq in sqDict.values{
            sq.removePiece()
        }
    }
    
    func piecesInGrid() -> Int{
        var numPieces:Int = 0
        for sq : GridSq in sqDict.values{
            if(sq.occupied()){numPieces+=1}
        }
        return numPieces
    }
    
    func pieceAtSq(coord:Coordinate) -> Piece{
        assert(sqDict[coord] != nil, "ERROR: pieceAtSq entered invalid coord")
        assert(sqDict[coord]!.contains != nil, "ERROR: no piece at that coordinate")
        
        var p:Piece = sqDict[coord]!.contains!
        return p
    }
    
    private func random(probability:Double) -> Bool{
        let aHighNum:Int = Int(1000000)
        if(Double(arc4random_uniform(UInt32(aHighNum) )) < (probability * aHighNum)){
            return true
        }
        return false
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}