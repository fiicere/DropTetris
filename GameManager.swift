//
//  GameManager.swift
//  DropTetris
//
//  Created by Kevin Yue on 11/20/14.
//  Copyright (c) 2014 Kevin Yue. All rights reserved.
//

import SpriteKit

class GameManager: SKNode {
    
    let marginRatio:CGFloat = 0.1
    
    var mainGrid:MainGrid
    var subGrid:SmallGrid
    
    var scoreLabel:SKLabelNode = SKLabelNode()
    
    override init(){
        mainGrid = MainGrid()
        subGrid = SmallGrid()
                
        super.init()
        
        addChild(mainGrid)
        addChild(subGrid)
        addScoreLabel()
        Score.resetScore()
        Difficulty.resetDifficulty()
    }
    
    func newTouch(touch:UITouch){
        var loc:CGPoint = touch.locationInNode(mainGrid)
        
        if(mainGrid.isInSq(loc)){
            attemptTransferTo(getTouchedSquare(loc))
        }
        
        loc = touch.locationInNode(subGrid)
        if(subGrid.isInSq(loc)){
            subGrid.rotate(Rotation.CW)
        }
    }
    
    func addIndicator(touch:UITouch){
        var loc:CGPoint = touch.locationInNode(mainGrid)
        if(mainGrid.isInSq(loc)){
            removeAllIndicators()
            
            var occupied = subGrid.getAllOccupied()
            
            if(isOnGrid(loc, occupied: occupied)){mainGrid.showIndicatorAroundLoc(loc, occupied: occupied)}
            else{mainGrid.showInvalidIndicatorAroundLoc(loc, occupied: occupied)}
            
        }
    }
    
    private func isOnGrid(loc:CGPoint, occupied:Array<GridSq>) -> Bool{
        var coord = mainGrid.getTouchedSq(loc)
        
        for subSQ:GridSq in occupied{
            if(!contains(mainGrid.sqDict.keys, coord + subSQ.coord)){return false}
        }
        
        return true
    }
    
    func removeAllIndicators(){
        for sq:GridSq in mainGrid.sqDict.values{
            sq.removeIndicator()
        }
    }
    
    private func getTouchedSquare(loc:CGPoint) -> Coordinate{
        return mainGrid.getTouchedSq(loc)
    }
    
    private func attemptTransferTo(coord:Coordinate){
        if(canTransferTo(coord)){
            transferTo(coord)
            subGrid.populate()
            clearRowsAndCols()
            Difficulty.increaseSpawnProb()
        }
    }
    
    private func clearRowsAndCols(){
        var toClear:Array<GridSq> = mainGrid.getSqToClear()
        Score.incrementScore(toClear.count * toClear.count)
        mainGrid.clearSquares(toClear)
    }
    
    func hasValidMove() -> Bool{
        for(var i = 0; i<4; i++){
            for coord:Coordinate in mainGrid.sqDict.keys{
                if(canTransferTo(coord)){
                    return true
                }
            }
            subGrid.rotate(Rotation.CW)
        }
        return false
    }
    
    private func canTransferTo(coord:Coordinate) -> Bool{
        for sq:GridSq in subGrid.getAllOccupied(){
            if(!mainGrid.canPlace(sq.coord + coord)){return false}
        }
        return true
    }
    
    private func transferTo(coord: Coordinate){
        for sq:GridSq in subGrid.getAllOccupied(){
            movePiece(sq.coord, mainGridCoord: sq.coord + coord)
        }
    }
    
    private func movePiece(subGridCoord: Coordinate, mainGridCoord:Coordinate){
        var p:Piece = subGrid.pieceAtSq(subGridCoord)
        subGrid.clearSq(subGridCoord)
        mainGrid.addPiece(p, coord: mainGridCoord)
    }
    
    func tick(){
        mainGrid.tick()
        subGrid.tick()
        updateScore()
        updateDifficulty()
    }
    
    private func addScoreLabel(){
        scoreLabel = SKLabelNode(fontNamed:Constants.font)
        scoreLabel.fontSize = Constants.labelFontSize
        scoreLabel.position = CGPoint.bottomRight + convertRatioToSize(CGVector(dx: marginRatio / Layout.widthToHeight, dy: marginRatio).half()).toPoint() * CGVector(dx: -1, dy: 1)
        scoreLabel.horizontalAlignmentMode = SKLabelHorizontalAlignmentMode.Right
        scoreLabel.fontColor = Constants.labelFontColor
        addChild(scoreLabel)
    }
    
    func updateScore(){
        scoreLabel.text =  Score.getScore()
    }
    
    func updateDifficulty(){
        Difficulty.update(Double(mainGrid.occupied().count) / mainGrid.dims.numCols / mainGrid.dims.numRows);
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}