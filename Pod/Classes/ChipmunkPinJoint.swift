//
//  ChipmunkPinJoint.swift
//  chipmunk-swift-wrapper
//
//  Created by Jakub Knejzlik on 16/11/15.
//  Copyright © 2015 CocoaPods. All rights reserved.
//

import Foundation

public class ChipmunkPinJoint: ChipmunkConstraint {
    public var anchor1: CGPoint {
        get {
            return cpPinJointGetAnchr1(self.constraint)
        }
        set(value) {
            cpPinJointSetAnchr1(self.constraint, value)
        }
    }
    public var anchor2: CGPoint {
        get {
            return cpPinJointGetAnchr2(self.constraint)
        }
        set(value) {
            cpPinJointSetAnchr2(self.constraint, value)
        }
    }
    public var distance: Double {
        get {
            return Double(cpPinJointGetDist(self.constraint))
        }
        set(value) {
            cpPinJointSetDist(self.constraint, cpFloat(value))
        }
    }
    
    public init(bodyA: ChipmunkBody, bodyB: ChipmunkBody, anchor1: CGPoint, anchor2: CGPoint, distance: Double) {
        super.init(bodyA: bodyA, bodyB: bodyB, constraint: cpPinJointNew(bodyA.body, bodyB.body, anchor1, anchor2))
    }
}