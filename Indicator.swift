//
//  Indicator.swift
//  DropTetris
//
//  Created by Kevin Yue on 12/27/14.
//  Copyright (c) 2014 Kevin Yue. All rights reserved.
//

import Foundation

class Indicator {
    var center:Coordinate
    var dims:GridDimension
    
    init(d:GridDimension){
        dims = d
        center = Coordinate.zero
    }
    
}