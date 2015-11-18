//
//  ChipmunkDampedSpring.swift
//  chipmunk-swift-wrapper
//
//  Created by Jakub Knejzlik on 16/11/15.
//  Copyright © 2015 CocoaPods. All rights reserved.
//

import Foundation

public class ChipmunkDampedSpring: ChipmunkConstraint {
    public var anchor1: CGPoint {
        get {
            return cpDampedSpringGetAnchr1(self.constraint)
        }
        set(value) {
            cpDampedSpringSetAnchr1(constraint, value);
        }
    }
    public var anchor2: CGPoint {
        get {
            return cpDampedSpringGetAnchr2(self.constraint)
        }
        set(value) {
            cpDampedSpringSetAnchr2(constraint, value);
        }
    }
    public var restLength: Double {
        get {
            return Double(cpDampedSpringGetRestLength(constraint))
        }
        set(value) {
            cpDampedSpringSetRestLength(constraint, cpFloat(value))
        }
    }
    public var stiffness: Double {
        get {
            return Double(cpDampedSpringGetRestLength(constraint))
        }
        set(value) {
            cpDampedSpringSetRestLength(constraint, cpFloat(value))
        }
    }
    public var damping: Double {
        get {
            return Double(cpDampedSpringGetRestLength(constraint))
        }
        set(value) {
            cpDampedSpringSetRestLength(constraint, cpFloat(value))
        }
    }
    
    public init(bodyA: ChipmunkBody, bodyB: ChipmunkBody, anchor1: CGPoint, anchor2: CGPoint, restLength: Double, stiffness: Double, damping: Double) {
        super.init(bodyA: bodyA, bodyB: bodyB, constraint: cpDampedSpringNew(bodyA.body, bodyB.body, anchor1, anchor2, cpFloat(restLength), cpFloat(stiffness), cpFloat(damping)))
    }
}