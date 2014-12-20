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
    let invalidTint = UIColor.redColor()
    let validTint = UIColor.greenColor()
    let noColorBlend:CGFloat = 1
    let defaultColorBlend:CGFloat = 0.5
    let pieceRatio = 0.9

    let myColor = UIColor.grayColor()
    
    init(sqSize:CGSize){
        super.init(texture: SKTexture(imageNamed: "Spaceship.png"), color: myColor, size: sqSize * pieceRatio)
    }
    
    convenience init(sqSize:CGSize, valid:Bool){
        self.init(sqSize: sqSize)
        addTint(valid)
    }
    
    func addTint(valid:Bool){
        if(valid){self.color = validTint}
        else{self.color = invalidTint}
        self.colorBlendFactor = defaultColorBlend
        self.zPosition = 10
    }
    
    func removeTint(){
        self.colorBlendFactor = noColorBlend
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}