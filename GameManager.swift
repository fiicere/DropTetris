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
        subGrid = SmallGrid()
        mainGrid = MainGrid(i: Indicator(occupied: subGrid.occupied()))
        
        super.init()
        
        addChild(mainGrid)
        addChild(subGrid)
        addScoreLabel()
        Score.resetScore()
        Difficulty.resetDifficulty()
    }
    
    /////////////////////TOUCH HANDLING////////////////////////

    func newTouch(touch:UITouch){
        var loc = touch.locationInNode(self)
        TouchManager.touchBegan(touch.hash, loc: loc)
    }
    
    func movedTouch(touch:UITouch){
        var loc = touch.locationInNode(self)
        TouchManager.touchMoved(touch.hash, loc: loc)
    }
    
    func touchEnded(touch:UITouch){
        var loc:CGPoint = touch.locationInNode(self)
        TouchManager.touchEnded(touch.hash, loc: loc)
        parseGesture()
    }
    
    private func getTouchedSquare(loc:CGPoint) -> Coordinate{
        return mainGrid.getTouchedSq(loc)
    }
    
    private func parseGesture(){
        var g:Gesture = TouchManager.popGesture()
        
        switch g.type{
        case GestureType.CLICK:
            parseClick(g)
        case GestureType.SWIPE:
            parseSwipe(g)
        case GestureType.ROTATE:
            parseRotate(g)
        default:
            return
        }
        
    }
    
    private func parseClick(g:Gesture){
        if(subGrid.frame.contains(g.loc)){} //TODO: Send click to subGrid: Rotate subGrid, rotate mainGrid.indicator
        else if(mainGrid.frame.contains(g.loc)){} //TODO: Send click to mainGrid: move Indicator, drop if there already
        else{} //TODO: Nothing?
    }
    
    private func parseSwipe(g:Gesture){
        //TODO: Send click to mainGrid, move Indicator
    }
    
    private func parseRotate(g:Gesture){
        //TODO: Send click to subGrid: Rotate subGrid, rotate mainGrid.indicator
    }
    
    //IMPORTANT TODO NOTE!!!
    // There are actually only 3 cases, rotate, translate, and drop. You can design accordingly
    
    private func attemptTransferTo(coord:Coordinate){
        if(canTransferTo(coord)){
            transferTo(coord)
            subGrid.populate()
            clearRowsAndCols()
            Difficulty.increaseSpawnProb()
            mainGrid.newIndicator(Indicator(occupied: subGrid.occupied()))
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