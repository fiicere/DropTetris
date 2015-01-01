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

    let myColor = UIColor.grayColor()
    
    override init(){
        super.init(texture: SKTexture(imageNamed: "Spaceship.png"), color: myColor, size: Layout.pieceSize)
    }
    
    convenience init(valid:Bool){
        self.init()
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