//
//  Indicator.swift
//  DropTetris
//
//  Created by Kevin Yue on 12/27/14.
//  Copyright (c) 2014 Kevin Yue. All rights reserved.
//

import Foundation

class Indicator:EmptyGrid{
    
    var center = Coordinate.zero
    
    override init(d: GridDimension) {
        super.init(d: d)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
