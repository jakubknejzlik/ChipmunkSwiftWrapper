//
//  ChipmunkGearJoint.swift
//  chipmunk-swift-wrapper
//
//  Created by Jakub Knejzlik on 16/11/15.
//  Copyright © 2015 CocoaPods. All rights reserved.
//

import Foundation

public class ChipmunkGearJoint: ChipmunkConstraint {
    public var phase: Double {
        get {
            return Double(cpGearJointGetPhase(self.constraint))
        }
        set(value) {
            return cpGearJointSetPhase(self.constraint,cpFloat(value))
        }
    }
    public var ratio: Double {
        get {
            return Double(cpGearJointGetRatio(self.constraint))
        }
        set(value) {
            return cpGearJointSetRatio(self.constraint,cpFloat(value))
        }
    }
    
    public init(bodyA: ChipmunkBody, bodyB: ChipmunkBody, phase: Double, ratio: Double) {
        super.init(bodyA: bodyA, bodyB: bodyB, constraint: cpGearJointNew(bodyA.body, bodyB.body, cpFloat(phase), cpFloat(ratio)))
    }
}