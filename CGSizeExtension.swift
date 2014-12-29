//
//  CGSizeExtension.swift
//  DropTetris
//
//  Created by Kevin Yue on 11/30/14.
//  Copyright (c) 2014 Kevin Yue. All rights reserved.
//

import Foundation

import CoreGraphics
import SpriteKit

public extension CGSize {

    public func toVector() -> CGVector{
        return CGVector(dx: self.width, dy: self.height)
    }
    
    public func half() -> CGSize{
        return self /  2
    }
}

//ADDITION
public func + (left: CGSize, right: CGSize) -> CGSize {
    return CGSize(width: left.width + right.width, height: left.height + right.height)
}

public func += (inout left: CGSize, right: CGSize) {
    left = left + right
}

public func + (left: CGSize, right: Int) -> CGSize {
    return CGSize(width: left.width + right, height: left.height + right)
}

public func += (inout left: CGSize, right: Int) {
    left = left + right
}

public func + (left: CGSize, right: Double) -> CGSize {
    return CGSize(width: left.width + right, height: left.height + right)
}

public func += (inout left: CGSize, right: Double) {
    left = left + right
}

public func + (left: CGSize, right: CGFloat) -> CGSize {
    return CGSize(width: left.width + right, height: left.height + right)
}

public func += (inout left: CGSize, right: CGFloat) {
    left = left + right
}

//SUBTRACTION
public func - (left: CGSize, right: CGSize) -> CGSize {
    return CGSize(width: left.width - right.width, height: left.height - right.height)
}

public func -= (inout left: CGSize, right: CGSize) {
    left = left - right
}

public func - (left: CGSize, right: Int) -> CGSize {
    return CGSize(width: left.width - right, height: left.height - right)
}

public func -= (inout left: CGSize, right: Int) {
    left = left - right
}

public func - (left: CGSize, right: Double) -> CGSize {
    return CGSize(width: left.width - right, height: left.height - right)
}

public func -= (inout left: CGSize, right: Double) {
    left = left - right
}

public func - (left: CGSize, right: CGFloat) -> CGSize {
    return CGSize(width: left.width - right, height: left.height - right)
}

public func -= (inout left: CGSize, right: CGFloat) {
    left = left - right
}

//MULTIPLICATION
public func * (left: CGSize, right: CGSize) -> CGSize {
    return CGSize(width: left.width * right.width, height: left.height * right.height)
}

public func *= (inout left: CGSize, right: CGSize) {
    left = left * right
}

public func * (left: CGSize, right: Int) -> CGSize {
    return CGSize(width: left.width * right, height: left.height * right)
}

public func *= (inout left: CGSize, right: Int) {
    left = left * right
}

public func * (left: CGSize, right: Double) -> CGSize {
    return CGSize(width: left.width * right, height: left.height * right)
}

public func *= (inout left: CGSize, right: Double) {
    left = left * right
}

public func * (left: CGSize, right: CGFloat) -> CGSize {
    return CGSize(width: left.width * right, height: left.height * right)
}

public func *= (inout left: CGSize, right: CGFloat) {
    left = left * right
}

//DIVISION
public func / (left: CGSize, right: CGSize) -> CGSize {
    return CGSize(width: left.width / right.width, height: left.height / right.height)
}

public func /= (inout left: CGSize, right: CGSize) {
    left = left / right
}

public func / (left: CGSize, right: Int) -> CGSize {
    return CGSize(width: left.width / right, height: left.height / right)
}

public func /= (inout left: CGSize, right: Int) {
    left = left / right
}

public func / (left: CGSize, right: Double) -> CGSize {
    return CGSize(width: left.width / right, height: left.height / right)
}

public func /= (inout left: CGSize, right: Double) {
    left = left / right
}

public func / (left: CGSize, right: CGFloat) -> CGSize {
    return CGSize(width: left.width / right, height: left.height / right)
}

public func /= (inout left: CGSize, right: CGFloat) {
    left = left / right
}


//TYPE CONVERSIONS
public func convertSizeToRatio(sizeInPixels:CGSize) -> CGSize{
    return sizeInPixels / Layout.screenSize
}

public func convertRatioToSize(sizeRatio:CGSize) -> CGSize{
    return sizeRatio * Layout.screenSize
}