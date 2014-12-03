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
    static var screenSize : CGSize = UIScreen.mainScreen().bounds.size
    static var widthToHeight : CGFloat = screenSize.width / screenSize.height
    
    static let blankColor = UIColor(red: 1, green: 0.0, blue: 0.0, alpha: 0.25)
}