//
//  GameOverManager.swift
//  DropTetris
//
//  Created by Kevin Yue on 12/20/14.
//  Copyright (c) 2014 Kevin Yue. All rights reserved.
//

import Foundation

enum GameType: String{
    case TIMED = "TIMED", ARCADE = "ARCADE", PUZZLE = "PUZZLE"
}

 class GameOverManager{
    var gameType:GameType
    
    init(type:GameType){
        gameType = type
    }
    
    func checkGameOver(mg:MainGrid, sg:SmallGrid)->Bool{
        switch gameType{
        case .TIMED:
            return isTimeUp()
        case .PUZZLE:
            return canMove()
        case .ARCADE:
            return moveTimeExpired()
        }
    }
    
    private func canMove() ->Bool{
        return true
    }
    
    private func isTimeUp() ->Bool{
        return true
    }
    
    private func moveTimeExpired() ->Bool{
        return true
    }
    
}