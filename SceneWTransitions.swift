//
//  SceneWTransitions.swift
//  DropTetris
//
//  Created by Kevin Yue on 11/20/14.
//  Copyright (c) 2014 Kevin Yue. All rights reserved.
//

import SpriteKit

class SceneWTransitions: SKScene {
    
    var isTransitioning:Bool = false

    override func didMoveToView(view: SKView) {
        Layout.screenSize = view.bounds.size
    }
    
    let duration = 0.5
    
    func flipHorizontalToThisScene(newScene:SceneWTransitions){
        if(!isTransitioning){
            let reveal = SKTransition.flipHorizontalWithDuration(duration)
            self.view?.presentScene(newScene, transition:reveal)
            isTransitioning = true
        }
    }
    
    func flipVerticalToThisScene(newScene:SceneWTransitions){
        if(!isTransitioning){
            let reveal = SKTransition.flipVerticalWithDuration(duration)
            self.view?.presentScene(newScene, transition:reveal)
            isTransitioning = true
        }
    }
    
    func closeHorizontalToThisScene(newScene:SceneWTransitions){
        if(!isTransitioning){
            let reveal = SKTransition.doorsCloseHorizontalWithDuration(duration)
            self.view?.presentScene(newScene, transition:reveal)
            isTransitioning = true
        }
    }
    
    func closeVerticalToThisScene(newScene:SceneWTransitions){
        if(!isTransitioning){
            let reveal = SKTransition.doorsCloseVerticalWithDuration(duration)
            self.view?.presentScene(newScene, transition:reveal)
            isTransitioning = true
        }
    }
    
    func openHorizontalToThisScene(newScene:SceneWTransitions){
        if(!isTransitioning){
            let reveal = SKTransition.doorsOpenHorizontalWithDuration(duration)
            self.view?.presentScene(newScene, transition:reveal)
            isTransitioning = true
        }

    }
    
    func openVerticalToThisScene(newScene:SceneWTransitions){
        if(!isTransitioning){
            let reveal = SKTransition.doorsOpenVerticalWithDuration(duration)
            self.view?.presentScene(newScene, transition:reveal)
            isTransitioning = true
        }
    }
    
    func doorwayToThisScene(newScene:SceneWTransitions){
        if(!isTransitioning){
            let reveal = SKTransition.doorwayWithDuration(duration)
            self.view?.presentScene(newScene, transition:reveal)
            isTransitioning = true
        }

    }
    
    func crossFadeToThisScene(newScene:SceneWTransitions){
        if(!isTransitioning){
            let reveal = SKTransition.crossFadeWithDuration(duration)
            self.view?.presentScene(newScene, transition:reveal)
            isTransitioning = true
        }
    }
    
    func fadeToThisScene(newScene:SceneWTransitions){
        if(!isTransitioning){
            let reveal = SKTransition.fadeWithDuration(duration)
            self.view?.presentScene(newScene, transition:reveal)
            isTransitioning = true
        }
    }
}