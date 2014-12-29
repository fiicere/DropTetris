//
//  Constants.swift
//  DropTetris
//
//  Created by Kevin Yue on 11/21/14.
//  Copyright (c) 2014 Kevin Yue. All rights reserved.
//

import Foundation
import CoreGraphics
import SpriteKit

struct Constants {
    //Screen Information
    static let screenSize : CGSize = UIScreen.mainScreen().bounds.size
    static let widthToHeight : CGFloat = screenSize.width / screenSize.height
    
    static let blankColor = UIColor(red: 1, green: 0.0, blue: 0.0, alpha: 0.25)
    
    static var font = "Chalkduster"
    static var menuFontSize:CGFloat = 60
    static var labelFontSize:CGFloat = 48
    static var labelFontColor:UIColor = UIColor.blackColor()
}

struct Font{
    
}

struct Layout{
    static let screenMarginRatio = 0.1
    static let screenMargin = convertRatioToSize(CGSize(width: scale * mainGridSizeRatio / Constants.widthToHeight, height: scale * mainGridSizeRatio))

    
}

