//
//  operators.swift
//  Super Simple Calculator
//
//  Created by Todd Resudek on 2/27/15.
//  Copyright (c) 2015 supersimple. All rights reserved.
//

import Foundation

class Operators {
    internal func adding(num1: NSNumber, num2: NSNumber) -> Double {
        var str = "\num1 + \num2"
        var result:Double = NSExpression(format: str).expressionValueWithObject(nil, context:nil) as Double;
        return result
    }
}