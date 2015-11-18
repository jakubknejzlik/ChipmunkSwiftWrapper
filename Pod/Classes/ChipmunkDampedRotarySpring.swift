//
//  ChipmunkDampedRotarySpring.swift
//  chipmunk-swift-wrapper
//
//  Created by Jakub Knejzlik on 16/11/15.
//  Copyright © 2015 CocoaPods. All rights reserved.
//

import Foundation

public class ChipmunkDampedRotarySpring: ChipmunkConstraint {
    public var restAngle: Double {
        get {
            return Double(cpDampedRotarySpringGetRestAngle(constraint))
        }
        set(value) {
            cpDampedRotarySpringSetRestAngle(constraint, cpFloat(value))
        }
    }
    public var stiffness: Double {
        get {
            return Double(cpDampedRotarySpringGetStiffness(constraint))
        }
        set(value) {
            cpDampedRotarySpringSetStiffness(constraint, cpFloat(value))
        }
    }
    public var damping: Double {
        get {
            return Double(cpDampedRotarySpringGetDamping(constraint))
        }
        set(value) {
            cpDampedRotarySpringSetDamping(constraint, cpFloat(value))
        }
    }
    
    public init(bodyA: ChipmunkBody, bodyB: ChipmunkBody, restAngle _restAngle: Double, stiffness _stiffness: Double, damping _damping: Double) {
        super.init(bodyA: bodyA, bodyB: bodyB, constraint: cpDampedRotarySpringNew(bodyA.body, bodyB.body, cpFloat(_restAngle), cpFloat(_stiffness), cpFloat(_damping)))
    }
}