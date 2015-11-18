//
//  ChipmunkGrooveJoint.swift
//  chipmunk-swift-wrapper
//
//  Created by Jakub Knejzlik on 16/11/15.
//  Copyright © 2015 CocoaPods. All rights reserved.
//

import Foundation

public class ChipmunkGrooveJoint: ChipmunkConstraint {
    public var grooveA: CGPoint{
        get {
            return cpGrooveJointGetGrooveA(self.constraint)
        }
        set(value) {
            cpGrooveJointSetGrooveA(self.constraint, value)
        }
    }
    public var grooveB: CGPoint{
        get {
            return cpGrooveJointGetGrooveB(self.constraint)
        }
        set(value) {
            cpGrooveJointSetGrooveB(self.constraint, value)
        }
    }
    public var anchor2: CGPoint{
        get {
            return cpGrooveJointGetAnchr2(self.constraint)
        }
        set(value) {
            cpGrooveJointSetAnchr2(self.constraint, value)
        }
    }

    public init(bodyA: ChipmunkBody, bodyB: ChipmunkBody, grooveA: CGPoint, grooveB: CGPoint, anchor2: CGPoint) {
        super.init(bodyA: bodyA, bodyB: bodyB, constraint: cpGrooveJointNew(bodyA.body, bodyB.body, grooveA, grooveB, anchor2))
    }
}