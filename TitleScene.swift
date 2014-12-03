//
//  TitleScene.swift
//  DropTetris
//
//  Created by Kevin Yue on 11/20/14.
//  Copyright (c) 2014 Kevin Yue. All rights reserved.
//

import Foundation
import SpriteKit


class TitleScene: SceneWTransitions {
    override func didMoveToView(view: SKView) {        
        super.didMoveToView(view)

        /* Setup your scene here */
        let myLabel = SKLabelNode(fontNamed:FontsAndSizes.font)
        myLabel.text = "Count to Ten";
        myLabel.fontSize = FontsAndSizes.menuFontSize;
        myLabel.position = CGPoint.middle;
        
        self.addChild(myLabel)
    }
    
    override func touchesBegan(touches: NSSet, withEvent event: UIEvent) {
        /* Called when a touch begins */
        self.fadeToThisScene(GameScene(size: self.size))
    }
    
    override func update(currentTime: CFTimeInterval) {
        /* Called before each frame is rendered */
    }
    
    
}