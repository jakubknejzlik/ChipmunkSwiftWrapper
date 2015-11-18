//
//  ChipmunkSlideJoint.swift
//  chipmunk-swift-wrapper
//
//  Created by Jakub Knejzlik on 16/11/15.
//  Copyright © 2015 CocoaPods. All rights reserved.
//

import Foundation

public class ChipmunkSlideJoint: ChipmunkConstraint {
    public var min: Double {
        get {
            return Double(cpSlideJointGetMin(self.constraint))
        }
        set(value) {
            cpSlideJointSetMin(self.constraint, cpFloat(value))
        }
    }
    public var max: Double {
        get {
            return Double(cpSlideJointGetMax(self.constraint))
        }
        set(value) {
            cpSlideJointSetMax(self.constraint, cpFloat(value))
        }
    }
    
    public init(bodyA: ChipmunkBody, bodyB: ChipmunkBody, anchor1: CGPoint, anchor2: CGPoint, min: Double, max: Double) {
        super.init(bodyA: bodyA, bodyB: bodyB, constraint: cpSlideJointNew(bodyA.body, bodyB.body, anchor1, anchor2, cpFloat(min), cpFloat(max)))
    }
}