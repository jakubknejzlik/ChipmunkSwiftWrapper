//
//  ChipmunkShape.swift
//  Pods
//
//  Created by Jakub Knejzlik on 15/11/15.
//
//

import Foundation

public class ChipmunkShape: ChipmunkSpaceObject {
    weak var body: ChipmunkBody?
    let shape: UnsafeMutablePointer<cpShape>

    override var space: ChipmunkSpace? {
        willSet {
            if let space = self.space {
                cpSpaceRemoveShape(space.space, self.shape)
            }
        }
        didSet {
            if let space = self.space {
                if let body = self.body where body.isStatic {
                    cpSpaceAddStaticShape(space.space, self.shape)
                } else {
                    cpSpaceAddShape(space.space, self.shape)
                }
            }
        }
    }
    
    /** A boolean value if this shape is a sensor or not. Sensors only call collision callbacks, and never generate real collisions.*/
    public var sensor: Bool {
        get {
            return Bool(cpShapeGetSensor(shape))
        }
        set(value) {
            cpShapeSetSensor(shape, value.cpBool())
        }
    }
    
    /** Elasticity of the shape. A value of 0.0 gives no bounce, while a value of 1.0 will give a “perfect” bounce. However due to inaccuracies in the simulation using 1.0 or greater is not recommended however. The elasticity for a collision is found by multiplying the elasticity of the individual shapes together. */
    public var elasticity: Double {
        get {
            return Double(cpShapeGetElasticity(shape))
        }
        set(value) {
            cpShapeSetElasticity(shape, cpFloat(value))
        }
    }
    
    /** Friction coefficient. Chipmunk uses the Coulomb friction model, a value of 0.0 is frictionless. The friction for a collision is found by multiplying the friction of the individual shapes together. */
    public var friction: Double {
        get {
            return Double(cpShapeGetFriction(shape))
        }
        set(value) {
            cpShapeSetFriction(shape, cpFloat(value))
        }
    }
    
    /** The surface velocity of the object. Useful for creating conveyor belts or players that move around. This value is only used when calculating friction, not resolving the collision. */
    public var surfaceVelocity: CGPoint {
        get {
            return cpShapeGetSurfaceVelocity(shape)
        }
        set(value) {
            cpShapeSetSurfaceVelocity(shape, value)
        }
    }
    
    /** You can assign types to Chipmunk collision shapes that trigger callbacks when objects of certain types touch.*/
    public var collisionType: AnyObject {
        get {
            return UnsafeMutablePointer<AnyObject>(bitPattern: cpShapeGetCollisionType(shape)).memory
        }
        set(value) {
            let pointer = unsafeAddressOf(value)
            cpShapeSetCollisionType(shape, pointer.getUIntValue())
        }
    }
    
    /** Shapes in the same non-zero group do not generate collisions. Useful when creating an object out of many shapes that you don’t want to self collide. Defaults to CP_NO_GROUP. */
    public var group: AnyObject {
        get {
            return UnsafeMutablePointer<AnyObject>(bitPattern: cpShapeGetGroup(shape)).memory
        }
        set(value) {
            let pointer = unsafeAddressOf(value)
            cpShapeSetGroup(shape, pointer.getUIntValue())
        }
    }

    /** Shapes only collide if they are in the same bit-planes. i.e. (a->layers & b->layers) != 0 By default, a shape occupies all bit-planes. */
    public var layers: UInt {
        get {
            return UInt(cpShapeGetLayers(shape))
        }
        set(value) {
            cpShapeSetLayers(shape, UInt32(value))
        }
    }

    
    init(body: ChipmunkBody, shape: UnsafeMutablePointer<cpShape>) {
        self.body = body
        self.shape = shape
        super.init()
        cpShapeSetUserData(shape, UnsafeMutablePointer<ChipmunkShape>(unsafeAddressOf(self)))
        body.addShape(self)
    }
    
    public convenience init(body: ChipmunkBody, radius: Double, offset: CGPoint) {
        self.init(body: body, shape: cpCircleShapeNew(body.body, cpFloat(radius), offset))
    }
    
    public convenience init(body: ChipmunkBody, size: CGSize) {
        self.init(body: body, shape: cpBoxShapeNew(body.body, cpFloat(size.width), cpFloat(size.height)))
    }
}