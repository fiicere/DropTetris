//
//  GridSq.swift
//  DropTetris
//
//  Created by Kevin Yue on 11/20/14.
//  Copyright (c) 2014 Kevin Yue. All rights reserved.
//

import SpriteKit

class GridSq : SKSpriteNode {
    let coord:Coordinate
    let myColor = UIColor.lightGrayColor()
    let clearColor = UIColor.blueColor()
    let margin = 0.95
    
    let switchBackRate:Double = 0.3
    var changeTime:Double = 0
    
    var contains:Piece? = nil
    
    init(coordinate:Coordinate, sqSize:CGSize){
        
        coord = coordinate
        
        super.init(texture: nil, color: myColor, size:sqSize * margin)
    }
    
    func addPiece(piece:Piece){
        if(!occupied()){
            contains = piece
            self.addChild(piece)
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
        changeTime = Clock.time
    }
    
    func tick(){
        if(Clock.time - changeTime > switchBackRate){
            changeColorBack()
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}