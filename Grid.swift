//
//  Grid.swift
//  DropTetris
//
//  Created by Kevin Yue on 11/20/14.
//  Copyright (c) 2014 Kevin Yue. All rights reserved.
//

import SpriteKit

class Grid: SKSpriteNode {
    
    let dims:GridDimension
    let defaultColor = UIColor.darkGrayColor()
    
    var sqDict:Dictionary<Coordinate, GridSq> = Dictionary<Coordinate, GridSq>()

    init(d:GridDimension) {
        dims = d
        
        assert((d.numCols % 2) == 1, "ERROR: Grids must have an odd number of squares")
        assert((d.numRows % 2) == 1, "ERROR: Grids must have an odd number of squares")
        
        super.init(texture: nil, color: defaultColor, size: dims.gridSize)
        
        self.position = dims.origin
        
        self.initGridSqs()
    }
    
    func initGridSqs(){
        for var x = dims.colMin(); x <= dims.colMax(); x+=1{
            for var y = dims.rowMin(); y <= dims.rowMax(); y+=1{
                var sq = GridSq(coordinate: Coordinate(x: x, y: y))
                self.addGridSq(sq)
            }
        }
    }
    
    private func addGridSq(sq:GridSq){
        sqDict.updateValue(sq, forKey: sq.coord)
        sq.position = CGPoint(x: sq.coord.x * Layout.gridSqSize.width, y: sq.coord.y * Layout.gridSqSize.height)
        self.addChild(sq)
    }
    
    func tick(){
        for sq:GridSq in sqDict.values{
            sq.tick()
        }
    }
    
    func occupied() -> Array<GridSq>{
        var a = Array<GridSq>()
        for sq:GridSq in sqDict.values{
            if (sq.occupied()) {a.append(sq)}
        }
        return a
    }
    
    func coordIsInGrid(c:Coordinate) -> Bool{
        return contains(sqDict.keys, c)
    }
    
    
    func addPiece(p:Piece, coord:Coordinate){
        var sq:GridSq = sqDict[coord]!
        sq.addPiece(p)
    }
    
    func clearSq(coord:Coordinate) {
        sqDict[coord]?.removePiece()
    }
    
    func updateGridSqs(){
        var allSqs = sqDict.values
        sqDict.removeAll(keepCapacity: true)
        
        for sq:GridSq in allSqs{
            sq.removeFromParent()
            addGridSq(sq)
        }
    }
    
    func isInSq(loc:CGPoint) -> Bool{
        for sq : GridSq in sqDict.values{
            if(CGRectContainsPoint(sq.frame, loc)){return true}
        }
        return false
    }
    
    func getAllOccupied() -> Array<GridSq>{
        var array:Array = Array<GridSq>()
        for sq:GridSq in sqDict.values{
            if(sq.occupied()){array.append(sq)}
        }
        return array
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func removeAllChildren() {
        sqDict.removeAll(keepCapacity: true)
        super.removeAllChildren()
    }

}


