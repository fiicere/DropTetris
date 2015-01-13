//
//  CGPointExtension.swift
//  DropTetris
//
//  Created by Kevin Yue on 11/20/14.
//  Copyright (c) 2014 Kevin Yue. All rights reserved.
//

import Foundation

/*
* Copyright (c) 2013-2014 Razeware LLC
*
* Permission is hereby granted, free of charge, to any person obtaining a copy
* of this software and associated documentation files (the "Software"), to deal
* in the Software without restriction, including without limitation the rights
* to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
* copies of the Software, and to permit persons to whom the Software is
* furnished to do so, subject to the following conditions:
*
* The above copyright notice and this permission notice shall be included in
* all copies or substantial portions of the Software.
*
* THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
* IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
* FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
* AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
* LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
* OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
* THE SOFTWARE.
*/

import CoreGraphics
import SpriteKit

public extension CGPoint {
    static var left: CGPoint = (Layout.screenSize.toVector() * CGVector(dx: 0, dy: 0.5)).toPoint()
    static var right: CGPoint = (Layout.screenSize.toVector() * CGVector(dx: 1, dy: 0.5)).toPoint()
    static var top: CGPoint = (Layout.screenSize.toVector() * CGVector(dx: 0.5, dy: 1)).toPoint()
    static var bottom: CGPoint = (Layout.screenSize.toVector() * CGVector(dx: 0.5, dy: 0)).toPoint()
    
    static var bottomLeft:CGPoint = (Layout.screenSize.toVector() * CGVector(dx: 0, dy: 0)).toPoint()
    static var bottomRight:CGPoint = (Layout.screenSize.toVector() * CGVector(dx: 1, dy: 0)).toPoint()
    static var topLeft:CGPoint = (Layout.screenSize.toVector() * CGVector(dx: 0, dy: 1)).toPoint()
    static var topRight:CGPoint = (Layout.screenSize.toVector() * CGVector(dx: 1, dy: 1)).toPoint()

    static var middle:CGPoint = (Layout.screenSize.toVector() * CGVector(dx: 0.5, dy: 0.5)).toPoint()

    /**
    * Creates a new CGPoint given a CGVector.
    */
    public init(vector: CGVector) {
        self.init(x: vector.dx, y: vector.dy)
    }
    
    /**
    * Adds (dx, dy) to the point.
    */
    public mutating func offset(#dx: CGFloat, dy: CGFloat) -> CGPoint {
        x += dx
        y += dy
        return self
    }
    
    public func toVector()->CGVector{
        return CGVector(dx: x, dy: y)
    }
    
    /**
    * Returns the length (magnitude) of the vector described by the CGPoint.
    */
    public func length() -> CGFloat {
        return sqrt(x*x + y*y)
    }
    
    /**
    * Returns the squared length of the vector described by the CGPoint.
    */
    public func lengthSquared() -> CGFloat {
        return x*x + y*y
    }
    
    /**
    * Normalizes the vector described by the CGPoint to length 1.0 and returns
    * the result as a new CGPoint.
    */
    func normalized() -> CGPoint {
        let len = length()
        return (len > 0) ? (self / len) : CGPoint.zeroPoint
    }
    
    /**
    * Normalizes the vector described by the CGPoint to length 1.0.
    */
    public mutating func normalize() -> CGPoint {
        self = normalized()
        return self
    }
    
    /**
    * Calculates the distance between two CGPoints. Pythagoras!
    */
    public func distanceTo(point: CGPoint) -> CGFloat {
        return (self - point).length()
    }
    
    /**
    * Returns the angle in radians of the vector described by the CGPoint.
    * The range of the angle is -π to π; an angle of 0 points to the right.
    */
    public var angle: CGFloat {
        return atan2(y, x)
    }
    
    public var left : CGPoint {
        return CGPoint(x: 0,y: 0.5)
    }
    
    public var right : CGPoint {
        return CGPoint(x: 1,y: 0.5)
    }
    
    public var top : CGPoint {
        return CGPoint(x: 0.5,y: 1)
    }
    
    public var bottom : CGPoint {
        return CGPoint(x: 0.5,y: 0)
    }

    public var bottomLeft : CGPoint {
        return CGPoint(x: 0,y: 0)
    }
    
    public var bottomRight : CGPoint {
        return CGPoint(x: 1,y: 0)
    }
    
    public var topRight : CGPoint {
        return CGPoint(x: 1,y: 1)
    }
    
    public var topLeft : CGPoint {
        return CGPoint(x: 0,y: 1)
    }
    
    public func getString() -> String{
        return "(\(x),\(y))"
    }
}

/**
* Adds two CGPoint values and returns the result as a new CGPoint.
*/
public func + (left: CGPoint, right: CGPoint) -> CGPoint {
    return CGPoint(x: left.x + right.x, y: left.y + right.y)
}

/**
* Increments a CGPoint with the value of another.
*/
public func += (inout left: CGPoint, right: CGPoint) {
    left = left + right
}

/**
* Adds a CGVector to this CGPoint and returns the result as a new CGPoint.
*/
public func + (left: CGPoint, right: CGVector) -> CGPoint {
    return CGPoint(x: left.x + right.dx, y: left.y + right.dy)
}

/**
* Increments a CGPoint with the value of a CGVector.
*/
public func += (inout left: CGPoint, right: CGVector) {
    left = left + right
}

/**
* Subtracts two CGPoint values and returns the result as a new CGPoint.
*/
public func - (left: CGPoint, right: CGPoint) -> CGPoint {
    return CGPoint(x: left.x - right.x, y: left.y - right.y)
}

/**
* Decrements a CGPoint with the value of another.
*/
public func -= (inout left: CGPoint, right: CGPoint) {
    left = left - right
}

/**
* Subtracts a CGVector from a CGPoint and returns the result as a new CGPoint.
*/
public func - (left: CGPoint, right: CGVector) -> CGPoint {
    return CGPoint(x: left.x - right.dx, y: left.y - right.dy)
}

/**
* Decrements a CGPoint with the value of a CGVector.
*/
public func -= (inout left: CGPoint, right: CGVector) {
    left = left - right
}

/**
* Multiplies two CGPoint values and returns the result as a new CGPoint.
*/
public func * (left: CGPoint, right: CGPoint) -> CGPoint {
    return CGPoint(x: left.x * right.x, y: left.y * right.y)
}

/**
* Multiplies a CGPoint with another.
*/
public func *= (inout left: CGPoint, right: CGPoint) {
    left = left * right
}

/**
* Multiplies the x and y fields of a CGPoint with the same scalar value and
* returns the result as a new CGPoint.
*/
public func * (point: CGPoint, scalar: CGFloat) -> CGPoint {
    return CGPoint(x: point.x * scalar, y: point.y * scalar)
}

/**
* Multiplies the x and y fields of a CGPoint with the same scalar value.
*/
public func *= (inout point: CGPoint, scalar: CGFloat) {
    point = point * scalar
}

/**
* Multiplies a CGPoint with a CGVector and returns the result as a new CGPoint.
*/
public func * (left: CGPoint, right: CGVector) -> CGPoint {
    return CGPoint(x: left.x * right.dx, y: left.y * right.dy)
}

/**
* Multiplies a CGPoint with a CGVector.
*/
public func *= (inout left: CGPoint, right: CGVector) {
    left = left * right
}

/**
* Divides two CGPoint values and returns the result as a new CGPoint.
*/
public func / (left: CGPoint, right: CGPoint) -> CGPoint {
    return CGPoint(x: left.x / right.x, y: left.y / right.y)
}

/**
* Divides a CGPoint by another.
*/
public func /= (inout left: CGPoint, right: CGPoint) {
    left = left / right
}

/**
* Divides the x and y fields of a CGPoint by the same scalar value and returns
* the result as a new CGPoint.
*/
public func / (point: CGPoint, scalar: CGFloat) -> CGPoint {
    return CGPoint(x: point.x / scalar, y: point.y / scalar)
}

/**
* Divides the x and y fields of a CGPoint by the same scalar value.
*/
public func /= (inout point: CGPoint, scalar: CGFloat) {
    point = point / scalar
}

/**
* Divides a CGPoint by a CGVector and returns the result as a new CGPoint.
*/
public func / (left: CGPoint, right: CGVector) -> CGPoint {
    return CGPoint(x: left.x / right.dx, y: left.y / right.dy)
}

/**
* Divides a CGPoint by a CGVector.
*/
public func /= (inout left: CGPoint, right: CGVector) {
    left = left / right
}

/**
* Performs a linear interpolation between two CGPoint values.
*/
public func lerp(#start: CGPoint, #end: CGPoint, #t: CGFloat) -> CGPoint {
    return CGPoint(x: start.x + (end.x - start.x)*t, y: start.y + (end.y - start.y)*t)
}