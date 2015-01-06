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
    
    let myGridDims:GridDimension
    private var indicator:Indicator
    
    convenience init(){
        var i = Indicator(occupied: Array<Coordinate>())
        
        self.init(i: i)
    }
    
    init(i:Indicator){
        indicator = i
        
        let mainGridSize = Layout.gridSqSize * Rules.mainGridN
        myGridDims = GridDimension(numRows: Rules.mainGridN, numCols: Rules.mainGridN,
            gridSize: mainGridSize,
            origin: (mainGridSize.toVector().half() + Layout.screenMarginSize.toVector()).toPoint());
        
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
    
    /////////////////////INDICATOR FUNCTIONS///////////////////
    func newIndicator(i:Indicator){
        indicator = i
        updateIndicator()
    }
    
    func moveIndicator(loc:CGPoint){
        indicator.moveTo(getTouchedSq(loc))
        updateIndicator()
    }
    
    func newIndicatorContents(c:Array<Coordinate>){
        indicator.newContents(c)
        updateIndicator()
    }
    
    func newIndicatorContents(c:Array<GridSq>){
        indicator.newContents(c)
        updateIndicator()
    }
    
    private func updateIndicator(){
        removeAllIndicators()
        addIndicators()
    }
    
    private func removeAllIndicators(){
        for sq:GridSq in sqDict.values{
            sq.removeIndicator()
        }
    }
    
    private func addIndicators(){
        if(indicator.indicatorInBounds(myGridDims.colMin(),
            xMax: myGridDims.colMax(),
            yMin: myGridDims.rowMin(),
            yMax: myGridDims.rowMax())){
                addValidIndicator()
        }
        else{
            addInvalidIndicator()
        }
    }
    
    private func addValidIndicator(){
        for c:Coordinate in indicator.getContents(){
            if let sq = sqDict[c]{sq.addIndicator()}
        }
    }
    
    private func addInvalidIndicator(){
        for c:Coordinate in indicator.getContents(){
            if let sq = sqDict[c]{sq.addInvalidIndicator()}
        }
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}