//
//  MainGrid.swift
//  DropTetris
//
//  Created by Kevin Yue on 12/1/14.
//  Copyright (c) 2014 Kevin Yue. All rights reserved.
//

import Foundation
import SpriteKit

class MainGrid: Grid {
        
    let mainGridN = 9
    
    let myGridDims:GridDimension
        
    init(){
        
        let mainGridSize = Layout.GridSqSize * Rules.mainGridN 
        
        myGridDims = GridDimension(numRows: mainGridN, numCols: mainGridN,
            gridSize: mainGridSize,
            origin: (mainGridSize.toVector().half() + Layout.screenMarginSize.toVector()).toPoint());
        
        println("My Size = (\(mainGridSize.width),\(mainGridSize.height))")
        
        super.init(d: myGridDims)
    }
    
    func getTouchedSq(loc:CGPoint) -> Coordinate{
        for sq : GridSq in sqDict.values{
            if(CGRectContainsPoint(sq.frame, loc)){return sq.coord}
        }
        return Coordinate.null
    }
    
    func canPlace(coord:Coordinate) -> Bool{
        if(sqDict[coord] == nil){return false}
        
        var sq:GridSq = sqDict[coord]!
        if(sq.occupied()){return false}
        return true
    }
    
    func canPlace(sq: GridSq) -> Bool{
        if(sq.occupied()){return false}
        if(sqDict[sq.coord] == nil){return false}
        return true
    }
    
    func getSqToClear() -> Array<GridSq>{
        var toClear:Array<GridSq> = Array<GridSq>()
        for(var x = dims.colMin(); x <= dims.colMax(); x++){
            var col:Array<GridSq> = getCol(x)
            if (isFull(col)){toClear.extend(col)}
        }
        
        for(var y:Int = dims.colMin(); y <= dims.colMax(); y++){
            var row:Array<GridSq> = getRow(y)
            if(isFull(row)){toClear.extend(row)}
        }
        return toClear
    }
    
    func showIndicatorAroundLoc(loc:CGPoint, occupied:Array<GridSq>){
        var coord = getTouchedSq(loc)
        for subSQ:GridSq in occupied{
            var mainSQ:GridSq? = sqDict[coord + subSQ.coord]
            if(mainSQ != nil){
                mainSQ!.addIndicator()
            }
        }
    }
    
    func showInvalidIndicatorAroundLoc(loc:CGPoint, occupied:Array<GridSq>){
        var coord = getTouchedSq(loc)
        for subSQ:GridSq in occupied{
            var mainSQ:GridSq? = sqDict[coord + subSQ.coord]
            if(mainSQ != nil){
                mainSQ!.addInvalidIndicator()
            }
        }
    }
    
    private func getRow(y:Int) -> Array<GridSq>{
        var a:Array<GridSq> = Array<GridSq>()
        for sq:GridSq in sqDict.values{
            if(sq.coord.y == y){a.append(sq)}
        }
        return a;
    }
    
    private func getCol(x:Int) -> Array<GridSq>{
        var a:Array<GridSq> = Array<GridSq>()
        for sq:GridSq in sqDict.values{
            if(sq.coord.x == x){a.append(sq)}
        }
        return a;
    }
    
    private func isFull(a:Array<GridSq>) -> Bool{
        for sq:GridSq in a{
            if(!sq.occupied()){return false}
        }
        return true;
    }
    
    func clearSquares(sqA:Array<GridSq>){
        for sq:GridSq in sqA{
            sq.removePiece()
            sq.changeColor()
        }
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}