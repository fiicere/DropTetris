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
        for touch in touches{
            if(!gameOver){
                gameManager.newTouch(touch as UITouch)
            }
        }

    }
    
    override func touchesMoved(touches: NSSet, withEvent event: UIEvent) {
        for touch in touches{
            if(!gameOver){
                gameManager.movedTouch(touch as UITouch)
            }
        }
    }
    
    override func touchesEnded(touches: NSSet, withEvent event: UIEvent) {
        for touch in touches{
            if(gameOver){
                self.fadeToThisScene(GameScene(size: size))
            }
            else{
                gameManager.touchEnded(touch as UITouch)
            }
        }
    }
    
    /* Called before each frame is rendered */
    override func update(currentTime: CFTimeInterval) {
        Score.update()
        gameManager.tick()
        if(checkGameOver()){endGame()}
    }
    
    func checkGameOver() -> Bool{
        return !gameManager.hasValidMove()
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
        let ggLabel = SKLabelNode(fontNamed:Constants.font)
        ggLabel.text = "Game Over"
        ggLabel.fontSize = Constants.menuFontSize
        ggLabel.position = CGPoint.middle;
        ggLabel.fontColor = UIColor.redColor()

        ggLabel.zPosition = 2
        
        self.addChild(ggLabel)
    }
}
