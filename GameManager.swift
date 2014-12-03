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
    var score = 0
    var scoreLabel:SKLabelNode = SKLabelNode()
    
    var validMoves:Array<Coordinate> = Array<Coordinate>()
    
    override init(){
        mainGrid = MainGrid(marginRatio: marginRatio)
        subGrid = SmallGrid(marginRatio: marginRatio)
                
        super.init()
        
        addChild(mainGrid)
        addChild(subGrid)
        addScoreLabel()
        newValidMoves()
    }
    
    func newTouch(touch:UITouch){
        var loc:CGPoint = touch.locationInNode(mainGrid)
        
        if(mainGrid.isInSq(loc)){
            attemptTransferTo(getTouchedSquare(loc))
        }
    }
    
    private func getTouchedSquare(loc:CGPoint) -> Coordinate{
        return mainGrid.getTouchedSq(loc)
    }
    
    private func attemptTransferTo(coord:Coordinate){
        if(contains(validMoves, coord)) {
            transferTo(coord)
            subGrid.populate()
            clearRowsAndCols()
            newValidMoves()
        }
    }
    
    private func clearRowsAndCols(){
        var toClear:Array<GridSq> = mainGrid.getSqToClear()
        score += toClear.count * toClear.count
        updateScore()
        mainGrid.clearSquares(toClear)
    }
    
    private func newValidMoves(){
        validMoves = Array<Coordinate>()
        for coord:Coordinate in mainGrid.sqDict.keys{
            if(canTransferTo(coord)){
                validMoves.append(coord)
            }
        }
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
    }
    
    private func addScoreLabel(){
        scoreLabel = SKLabelNode(fontNamed:FontsAndSizes.font)
        scoreLabel.fontSize = FontsAndSizes.labelFontSize
        scoreLabel.position = CGPoint.bottomRight + convertRatioToSize(CGVector(dx: marginRatio / Constants.widthToHeight, dy: marginRatio).half()).toPoint() * CGVector(dx: -1, dy: 1)
        scoreLabel.horizontalAlignmentMode = SKLabelHorizontalAlignmentMode.Right
        scoreLabel.fontColor = FontsAndSizes.labelFontColor
        updateScore()
        addChild(scoreLabel)
    }
    
    func updateScore(){
        scoreLabel.text = "\(score)"
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}