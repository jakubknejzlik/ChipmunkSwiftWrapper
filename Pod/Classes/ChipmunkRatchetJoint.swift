//
//  ChipmunkRatchetJoint.swift
//  chipmunk-swift-wrapper
//
//  Created by Jakub Knejzlik on 16/11/15.
//  Copyright © 2015 CocoaPods. All rights reserved.
//

import Foundation

public class ChipmunkRatchetJoint: ChipmunkConstraint {
    public var phase: Double {
        get {
            return Double(cpRatchetJointGetPhase(self.constraint))
        }
        set(value) {
            cpRatchetJointSetPhase(self.constraint, cpFloat(value))
        }
    }
    public var ratchet: Double {
        get {
            return Double(cpRatchetJointGetRatchet(self.constraint))
        }
        set(value) {
            cpRatchetJointSetRatchet(self.constraint, cpFloat(value))
        }
    }
    
    public init(bodyA: ChipmunkBody, bodyB: ChipmunkBody, phase: Double, ratchet: Double) {
        super.init(bodyA: bodyA, bodyB: bodyB, constraint: cpRatchetJointNew(bodyA.body, bodyB.body, cpFloat(phase), cpFloat(ratchet)))
    }
}