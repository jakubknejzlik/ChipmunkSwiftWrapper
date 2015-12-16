//
//  ChipmunkConstraint.swift
//  chipmunk-swift-wrapper
//
//  Created by Jakub Knejzlik on 16/11/15.
//  Copyright © 2015 CocoaPods. All rights reserved.
//

import Foundation

public class ChipmunkConstraint: ChipmunkSpaceObject {
    public let bodyA: ChipmunkBody
    public let bodyB: ChipmunkBody
    public let constraint: UnsafeMutablePointer<cpConstraint>
    
    override var space: ChipmunkSpace? {
        willSet {
            if let space = self.space {
                cpSpaceRemoveConstraint(space.space, self.constraint)
            }
        }
        didSet {
            if let space = self.space {
                cpSpaceAddConstraint(space.space, self.constraint)
            }
        }
    }
    
    public init(bodyA: ChipmunkBody, bodyB: ChipmunkBody, constraint: UnsafeMutablePointer<cpConstraint>) {
        self.bodyA = bodyA
        self.bodyB = bodyB
        self.constraint = constraint
        super.init()
    }
    
    
}