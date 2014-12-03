//
//  Piece.swift
//  DropTetris
//
//  Created by Kevin Yue on 12/1/14.
//  Copyright (c) 2014 Kevin Yue. All rights reserved.
//

import Foundation
import SpriteKit


class Piece: SKSpriteNode {
    let myColor = UIColor.lightGrayColor()
    
    init(sqSize:CGSize){
        
        super.init(texture: SKTexture(imageNamed: "Spaceship.png"), color: myColor, size: sqSize)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}