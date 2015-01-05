//
//  GridSq.swift
//  DropTetris
//
//  Created by Kevin Yue on 11/20/14.
//  Copyright (c) 2014 Kevin Yue. All rights reserved.
//

import SpriteKit

class GridSq : SKSpriteNode {
    var coord:Coordinate
    let myColor = UIColor.lightGrayColor()
    let clearColor = UIColor.whiteColor()
    
    var changeBackTimer:Timer = Timer()
    
    var contains:Piece? = nil
    var indicator:Piece? = nil

    
    init(coordinate:Coordinate){
        
        coord = coordinate
        
        super.init(texture: nil, color: myColor, size:Layout.gridSqSize - Layout.gridSqMarginPixels)
    }
    
    func addPiece(){
        addPiece(Piece())
    }
    
    func addPiece(p:Piece){
        if(!occupied()){
            var p:Piece = Piece()
            contains = p
            self.addChild(p)
        }
    }
    
    func removePiece(){
        if(occupied()){
            contains?.removeFromParent()
            contains = nil
        }
    }
    
    func occupied() -> Bool{
        return (contains != nil)
    }
    
    private func changeColorBack(){
        if color != UIColor.lightGrayColor(){
            color = UIColor.lightGrayColor()
        }
    }
    
    func changeColor(){
        color = clearColor
        changeBackTimer = Timer()
    }
    
    func tick(){
        if(changeBackTimer.timeElapsed() > Rules.flashDuration){changeColorBack()}
    }
    
    func addIndicator(){
        indicator = Piece(valid: !occupied())
        self.addChild(indicator!)
    }
    
    func addInvalidIndicator(){
        indicator = Piece(valid:false)
        self.addChild(indicator!)
    }
    
    func removeIndicator(){
        if(indicator != nil){
            indicator?.removeFromParent()
        }
        indicator = nil
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}