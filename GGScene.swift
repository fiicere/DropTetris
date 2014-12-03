//
//  GGScene.swift
//  DropTetris
//
//  Created by Kevin Yue on 12/2/14.
//  Copyright (c) 2014 Kevin Yue. All rights reserved.
//

import Foundation

import SpriteKit


class GGScene: SceneWTransitions {
    override func didMoveToView(view: SKView) {
        super.didMoveToView(view)
        
        /* Setup your scene here */
        let myLabel = SKLabelNode(fontNamed:"Chalkduster")
        myLabel.text = "No More Moves";
        myLabel.fontSize = 65;
        myLabel.position = CGPoint(x:CGRectGetMidX(self.frame), y:CGRectGetMidY(self.frame));
        
        backgroundColor = SKColor.redColor()

        self.addChild(myLabel)
    }
    
    override func touchesBegan(touches: NSSet, withEvent event: UIEvent) {
        /* Called when a touch begins */
        self.fadeToThisScene(GameScene())
    }
    
    override func update(currentTime: CFTimeInterval) {
        /* Called before each frame is rendered */
    }
    
    
}