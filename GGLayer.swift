//
//  GGLayer.swift
//  DropTetris
//
//  Created by Kevin Yue on 12/2/14.
//  Copyright (c) 2014 Kevin Yue. All rights reserved.
//

import Foundation
import SpriteKit


class GGLayer: SKSpriteNode {
    
    let defaultColor = UIColor(red: 1, green: 0.0, blue: 0.0, alpha: 0.25)

    
    init(size:CGSize) {
        super.init(texture: nil, color: defaultColor, size:size * 2)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}