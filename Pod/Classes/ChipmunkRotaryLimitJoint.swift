//
//  ChipmunkRotaryLimitJoint.swift
//  chipmunk-swift-wrapper
//
//  Created by Jakub Knejzlik on 16/11/15.
//  Copyright © 2015 CocoaPods. All rights reserved.
//

import Foundation

public class ChipmunkRotaryLimitJoint: ChipmunkConstraint {
    public var min: Double {
        get {
            return Double(cpRotaryLimitJointGetMin(self.constraint))
        }
        set(value) {
            cpRotaryLimitJointSetMin(self.constraint, cpFloat(value))
        }
    }
    public var max: Double {
        get {
            return Double(cpRotaryLimitJointGetMax(self.constraint))
        }
        set(value) {
            cpRotaryLimitJointSetMax(self.constraint, cpFloat(value))
        }
    }
    
    public init(bodyA: ChipmunkBody, bodyB: ChipmunkBody, min: Double, max: Double) {
        super.init(bodyA: bodyA, bodyB: bodyB, constraint: cpRotaryLimitJointNew(bodyA.body, bodyB.body, cpFloat(min), cpFloat(max)))
    }
}