//
//  Constants.swift
//  DropTetris
//
//  Created by Kevin Yue on 11/21/14.
//  Copyright (c) 2014 Kevin Yue. All rights reserved.
//

import Foundation
import SpriteKit

struct Constants {
    
    static let blankColor = UIColor(red: 1, green: 0.0, blue: 0.0, alpha: 0.25)
    
    static var font = "Chalkduster"
    static var menuFontSize:CGFloat = 60
    static var labelFontSize:CGFloat = 48
    static var labelFontColor:UIColor = UIColor.blackColor()
}

struct Rules {
    static let mainGridN = 7
    static let subGridN = 3
    static let flashDuration:Double = 0.2

}

struct Layout{
    // Screen Info
    static var screenSize : CGSize = UIScreen.mainScreen().bounds.size
    static var widthToHeight : CGFloat = screenSize.width / screenSize.height
    
    // Screen Margins
    private static let screenMarginRatio : CGFloat = 0.05
    static let screenMargin = screenSize.height * screenMarginRatio
    static let screenMarginSize = CGSize(width: screenMargin, height: screenMargin)
    
    // Grid Margins
    private static let gridLineThickness = 2
    static let gridLineSize = CGSize(width: gridLineThickness, height: gridLineThickness)
    
    // GridSq
    static let gridSqSize = CGSize(width: screenSize.height - 2 * screenMargin,
        height: screenSize.height - 2 * screenMargin) / Rules.mainGridN
    static let gridSqMarginPixels = 2
    
    // Piece
    private static let pieceMarginRatio = 0.9
    static let pieceSize = gridSqSize * pieceMarginRatio


}

struct TouchConstants{
    static let touchSwipeRadius = 20 //Distance for a touch to be considered a swipe
    static let touchSwipeDuration = 0.5 //Time before a swipe is considered a hold
    static let finishedTouchDuration = 0.75 //Time before deleting finished touches
    
}












