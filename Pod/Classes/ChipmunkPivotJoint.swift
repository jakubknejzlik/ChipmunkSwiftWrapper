//
//  ChipmunkPivotJoint.swift
//  chipmunk-swift-wrapper
//
//  Created by Jakub Knejzlik on 16/11/15.
//  Copyright © 2015 CocoaPods. All rights reserved.
//

import Foundation

public class ChipmunkPivotJoint: ChipmunkConstraint {
    public var anchor1: CGPoint {
        get {
            return cpPivotJointGetAnchr1(self.constraint)
        }
        set(value) {
            cpPivotJointSetAnchr1(self.constraint, value)
        }
    }
    public var anchor2: CGPoint {
        get {
            return cpPivotJointGetAnchr2(self.constraint)
        }
        set(value) {
            cpPivotJointSetAnchr2(self.constraint, value)
        }
    }
    
    public init(bodyA: ChipmunkBody, bodyB: ChipmunkBody, anchor1: CGPoint, anchor2: CGPoint) {
        super.init(bodyA: bodyA, bodyB: bodyB, constraint: cpPivotJointNew2(bodyA.body, bodyB.body, anchor1, anchor2))
    }
    
    public init(bodyA: ChipmunkBody, bodyB: ChipmunkBody, pivot: CGPoint) {
        super.init(bodyA: bodyA, bodyB: bodyB, constraint: cpPivotJointNew(bodyA.body, bodyB.body, pivot))
    }
}