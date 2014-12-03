//
//  CGVectorExtension.swift
//  DropTetris
//
//  Created by Kevin Yue on 12/1/14.
//  Copyright (c) 2014 Kevin Yue. All rights reserved.
//

import Foundation
import CoreGraphics

public extension CGVector {

    public func toPoint() -> CGPoint{
        return CGPoint(x: self.dx, y: self.dy)
    }
    
    public func half() -> CGVector{
        return CGVector(dx: self.dx / 2, dy: self.dy / 2)
    }
}

//ADDITION
public func + (left: CGVector, right: CGVector) -> CGVector {
    return CGVector(dx: left.dx + right.dx, dy: left.dy+right.dy)
}

public func += (inout left: CGVector, right: CGVector) {
    left = left + right
}

//SUBTRACTION
public func - (left: CGVector, right: CGVector) -> CGVector {
    return CGVector(dx: left.dx - right.dx, dy: left.dy - right.dy)
}

public func -= (inout left: CGVector, right: CGVector) {
    left = left - right
}

//MULTIPLICATION
public func * (left: CGVector, right: CGVector) -> CGVector {
    return CGVector(dx: left.dx * right.dx, dy: left.dy * right.dy)
}

public func *= (inout left: CGVector, right: CGVector) {
    left = left + right
}

//DIVISION
public func / (left: CGVector, right: CGVector) -> CGVector {
    return CGVector(dx: left.dx / right.dx, dy: left.dy / right.dy)
}

public func /= (inout left: CGVector, right: CGVector) {
    left = left / right
}