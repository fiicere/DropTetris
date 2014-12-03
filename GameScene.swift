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
    var gameOver = false

    override func didMoveToView(view: SKView) {
        super.didMoveToView(view)
        
        backgroundColor = SKColor.whiteColor()
        
        gameManager.zPosition = 1
        self.addChild(gameManager);
    }
    
    override func touchesBegan(touches: NSSet, withEvent event: UIEvent) {
        if(gameOver){
            self.fadeToThisScene(GameScene(size: size))
        }
        else{
            let touch = touches.anyObject() as UITouch
            let touchLocation = touch.locationInNode(self)
            gameManager.newTouch(touch)
        }
    }
   
    /* Called before each frame is rendered */
    override func update(currentTime: CFTimeInterval) {
        gameManager.tick()
        Clock.updateTime(currentTime)
        
        if(checkGameOver()){endGame()}
    }
    
    func checkGameOver() -> Bool{
        if(gameManager.validMoves.count == 0){
            return true
        }
        return false
    }
    
    func endGame(){
        if(!gameOver){
            gameOver = true
            self.addGGLayer()
            self.addLabel()
        }
    }
    
    func addGGLayer(){
        let ggLayer = GGLayer(size: size)
        ggLayer.zPosition = -1
        self.addChild(GGLayer(size: size))
    }
    
    func addLabel(){
        let ggLabel = SKLabelNode(fontNamed:FontsAndSizes.font)
        ggLabel.text = "Game Over"
        ggLabel.fontSize = FontsAndSizes.menuFontSize
        ggLabel.position = CGPoint.middle;
        ggLabel.fontColor = UIColor.redColor()

        ggLabel.zPosition = 2
        
        self.addChild(ggLabel)
    }
}
