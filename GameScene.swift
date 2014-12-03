//
//  GameScene.swift
//  DropTetris
//
//  Created by Kevin Yue on 11/20/14.
//  Copyright (c) 2014 Kevin Yue. All rights reserved.
//

import SpriteKit

class GameScene: SceneWTransitions {
    
    var gameManager : GameManager = GameManager()

    override func didMoveToView(view: SKView) {
        super.didMoveToView(view)
        
        backgroundColor = SKColor.whiteColor()
        
        self.addChild(gameManager);
    }
    
    override func touchesBegan(touches: NSSet, withEvent event: UIEvent) {
        let touch = touches.anyObject() as UITouch
        let touchLocation = touch.locationInNode(self)
        
        gameManager.newTouch(touch)
    }
   
    /* Called before each frame is rendered */
    override func update(currentTime: CFTimeInterval) {
        gameManager.tick()
        Clock.updateTime(currentTime)
        
        if(checkGameOver()){gameOver()}
    }
    
    func checkGameOver() ->Bool{
        if(gameManager.validMoves.count == 0){
            return true
        }
        return false
    }
    
    func gameOver(){
        self.fadeToThisScene(GGScene())
    }
}
