//
//  ChipmunkSimpleMotor.swift
//  chipmunk-swift-wrapper
//
//  Created by Jakub Knejzlik on 16/11/15.
//  Copyright © 2015 CocoaPods. All rights reserved.
//

import Foundation

public class ChipmunkSimpleMotor: ChipmunkConstraint {
    public var rate: Double {
        get {
            return Double(cpSimpleMotorGetRate(self.constraint))
        }
        set(value) {
            cpSimpleMotorSetRate(self.constraint, cpFloat(value))
        }
    }
    
    public init(bodyA: ChipmunkBody, bodyB: ChipmunkBody, rate: Double) {
        super.init(bodyA: bodyA, bodyB: bodyB, constraint: cpSimpleMotorNew(bodyA.body, bodyB.body, cpFloat(rate)))
    }
}