//
//  ChipmunkArbiter.swift
//  Pods
//
//  Created by Jakub Knejzlik on 16/11/15.
//
//

import Foundation

public class ChipmunkArbiter {
    let arbiter: UnsafeMutablePointer<cpArbiter>

    /** The calculated elasticity for this collision pair. Setting the value in a preSolve() callback will override the value calculated by the space. The default calculation multiplies the elasticity of the two shapes together.*/
    public var elasticity: Double {
        get {
            return Double(cpArbiterGetElasticity(arbiter))
        }
        set(value) {
            cpArbiterSetElasticity(arbiter, cpFloat(value))
        }
    }
    
    /** The calculated friction for this collision pair. Setting the value in a preSolve() callback will override the value calculated by the space. The default calculation multiplies the friction of the two shapes together.*/
    public var friction: Double {
        get {
            return Double(cpArbiterGetFriction(arbiter))
        }
        set(value) {
            cpArbiterSetFriction(arbiter, cpFloat(value))
        }
    }
    
    /** The calculated surface velocity for this collision pair. Setting the value in a preSolve() callback will override the value calculated by the space. the default calculation subtracts the surface velocity of the second shape from the first and then projects that onto the tangent of the collision. This is so that only friction is affected by default calculation. Using a custom calculation, you can make something that responds like a pinball bumper, or where the surface velocity is dependent on the location of the contact point. */
    public var surfaceVelocity: CGPoint {
        get {
            return cpArbiterGetSurfaceVelocity(arbiter)
        }
        set(value) {
            cpArbiterSetSurfaceVelocity(arbiter, value)
        }
    }
    
    /** Get the number of contacts tracked by this arbiter or the specific collision point, collision normal or penetration depth of a collision point.*/
    public var count: Int32 {
        return cpArbiterGetCount(arbiter)
    }
    
    public func normalForContact(index: Int32) -> CGPoint {
        return cpArbiterGetNormal(arbiter, index)
    }
    public func pointForContact(index: Int32) -> CGPoint {
        return cpArbiterGetPoint(arbiter, index)
    }
    public func depthForContact(index: Int32) -> Double {
        return Double(cpArbiterGetDepth(arbiter, index))
    }
    
    var isFirstContact: Bool {
        return Bool(cpArbiterIsFirstContact(arbiter))
    }
    
    public func shapes() -> [ChipmunkShape] {
        var array: [ChipmunkShape] = []
        let shapeA: UnsafeMutablePointer<UnsafeMutablePointer<cpShape>> = UnsafeMutablePointer<UnsafeMutablePointer<cpShape>>()
        let shapeB: UnsafeMutablePointer<UnsafeMutablePointer<cpShape>> = UnsafeMutablePointer<UnsafeMutablePointer<cpShape>>()
        cpArbiterGetShapes(self.arbiter, shapeA, shapeB)
        array.append(UnsafeMutablePointer<ChipmunkShape>(cpShapeGetUserData(shapeA.memory)).memory)
        array.append(UnsafeMutablePointer<ChipmunkShape>(cpShapeGetUserData(shapeB.memory)).memory)
        return array
    }
    public func bodies() -> [ChipmunkShape] {
        var array: [ChipmunkShape] = []
        let bodyA: UnsafeMutablePointer<UnsafeMutablePointer<cpBody>> = UnsafeMutablePointer<UnsafeMutablePointer<cpBody>>()
        let bodyB: UnsafeMutablePointer<UnsafeMutablePointer<cpBody>> = UnsafeMutablePointer<UnsafeMutablePointer<cpBody>>()
        cpArbiterGetBodies(self.arbiter, bodyA, bodyB)
        array.append(UnsafeMutablePointer<ChipmunkShape>(cpBodyGetUserData(bodyA.memory)).memory)
        array.append(UnsafeMutablePointer<ChipmunkShape>(cpBodyGetUserData(bodyB.memory)).memory)
        return array
    }
    
    init(arbiter: UnsafeMutablePointer<cpArbiter>) {
        self.arbiter = arbiter
    }

}