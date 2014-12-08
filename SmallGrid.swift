//
//  SmallGrid.swift
//  DropTetris
//
//  Created by Kevin Yue on 12/1/14.
//  Copyright (c) 2014 Kevin Yue. All rights reserved.
//

import Foundation
import SpriteKit

class SmallGrid: Grid {
    let subGridSizeRatio:CGFloat = 0.33333333333
    let subGridN = 3
    
    let myGridDims:GridDimension
    
    init(marginRatio:CGFloat){
        let scale = 1 - marginRatio
        
        let subGridSize = convertRatioToSize(CGSize(width: scale * subGridSizeRatio / Constants.widthToHeight, height: scale * subGridSizeRatio))
        let margin:CGVector = convertRatioToSize(CGVector(dx: marginRatio / Constants.widthToHeight, dy: marginRatio).half())
        
        myGridDims = GridDimension(numRows: subGridN, numCols: subGridN,
            gridSize: subGridSize,
            origin: CGPoint.topRight - margin - subGridSize.toVector().half());
        
        super.init(d: myGridDims)
        
        populate()
    }
    
    func resetPieces(){
        clearAllPieces()
        populate()
    }
    
    func populate(){
        for sq : GridSq in sqDict.values{
            if(self.random()){
                sq.addPiece()
            }
        }
        if(piecesInGrid() == 0){
            populate()
        }
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
    
    func getAllOccupied() -> Array<GridSq>{
        var array:Array = Array<GridSq>()
        for sq:GridSq in sqDict.values{
            if(sq.occupied()){array.append(sq)}
        }
        return array
    }
    
    func pieceAtSq(coord:Coordinate) -> Piece{
        assert(sqDict[coord] != nil, "ERROR: pieceAtSq entered invalid coord")
        assert(sqDict[coord]!.contains != nil, "ERROR: no piece at that coordinate")
        
        var p:Piece = sqDict[coord]!.contains!
        return p
    }
    
    func clearSq(coord:Coordinate) {
        sqDict[coord]?.removePiece()
    }
    
    private func random() -> Bool{
        let aHighNum:Int = Int(1000000)
        if(Double(arc4random_uniform(UInt32(aHighNum) )) < (Difficulty.getSpawnProb() * aHighNum)){
            return true
        }
        return false
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}