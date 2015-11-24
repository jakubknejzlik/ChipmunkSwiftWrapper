//
//  ChipmunkBody.swift
//  Pods
//
//  Created by Jakub Knejzlik on 15/11/15.
//
//

import Foundation

public protocol ChipmunkBodyNode {
    func chipmunk_updateBodyPosition(body: ChipmunkBody)
//    func chipmunk_step(interval: NSTimeInterval)
    func chipmunk_update(interval: NSTimeInterval, delta: NSTimeInterval)
}

public class ChipmunkBody: ChipmunkSpaceObject {
    let body: UnsafeMutablePointer<cpBody>
    
    public var node: ChipmunkBodyNode?
    
    var previousPosition: CGPoint?
    var previousAngle: Double?
    
    override var space: ChipmunkSpace? {
        willSet {
            if let space = self.space {
                cpSpaceRemoveBody(space.space, self.body)
            }
        }
        didSet {
            if let space = self.space {
                if !self.isStatic {
                    cpSpaceAddBody(space.space, self.body)
                }
                self.updatePositionFromNode()
                for shape in self.shapes {
                    space.addObject(shape)
                }
            }
        }
    }
    
    public var isSleeping: Bool {
        return Bool(cpBodyIsSleeping(body))
    }
    public var isRogue: Bool {
        return Bool(cpBodyIsRogue(body))
    }
    public var isStatic: Bool {
        return Bool(cpBodyIsStatic(body))
    }
    public var mass: Double {
        get {
            return Double(cpBodyGetMass(self.body))
        }
        set(value) {
            cpBodySetMass(self.body, cpFloat(value))
        }
    }
    public var moment: Double {
        get {
            return Double(cpBodyGetMoment(self.body))
        }
        set(value) {
            cpBodySetMoment(self.body, cpFloat(value))
        }
    }
    public var position: CGPoint {
        get {
            return cpBodyGetPos(self.body)
        }
        set(value) {
            cpBodySetPos(self.body, value)
        }
    }
    public var velocity: CGPoint {
        get {
            return cpBodyGetVel(self.body)
        }
        set(value) {
            cpBodySetVel(self.body, value)
        }
    }
    public var force: CGPoint {
        get {
            return cpBodyGetForce(self.body)
        }
        set(value) {
            cpBodySetForce(self.body, value)
        }
    }
    public var angle: Double {
        get {
            return Double(cpBodyGetAngle(self.body))
        }
        set(value) {
            cpBodySetAngle(self.body, cpFloat(value))
        }
    }
    public var angularVelocity: Double {
        get {
            return Double(cpBodyGetAngVel(self.body))
        }
        set(value) {
            cpBodySetAngVel(self.body, cpFloat(value))
        }
    }
    public var torque: Double {
        get {
            return Double(cpBodyGetTorque(self.body))
        }
        set(value) {
            cpBodySetTorque(self.body, cpFloat(value))
        }
    }
    public var velocityLimit: Double {
        get {
            return Double(cpBodyGetVelLimit(self.body))
        }
        set(value) {
            cpBodySetVelLimit(self.body, cpFloat(value))
        }
    }
    public var angularVelocityLimit: Double {
        get {
            return Double(cpBodyGetAngVelLimit(self.body))
        }
        set(value) {
            cpBodySetAngVelLimit(self.body, cpFloat(value))
        }
    }
    
    
    lazy var shapes: Set<ChipmunkShape> = []
    func addShape(shape: ChipmunkShape) {
        shape.body = self
        if let space = self.space {
            space.addObject(shape)
        }
        self.shapes.insert(shape)
    }
    
    public init(body: UnsafeMutablePointer<cpBody>) {
        self.body = body
        super.init()
        cpBodySetUserData(self.body, UnsafeMutablePointer<ChipmunkBody>(unsafeAddressOf(self)))
    }
    
    public convenience init(mass: Double, moment: Double) {
        self.init(body: cpBodyNew(cpFloat(mass), cpFloat(moment)))
    }
    public class func staticBody() -> ChipmunkBody {
        return ChipmunkBody(body: cpBodyNewStatic())
    }
    
    public class func boxBody(mass: Double, size: CGSize) -> ChipmunkBody {
        return ChipmunkBody(mass: mass, moment: Double(cpMomentForBox(cpFloat(mass), cpFloat(size.width), cpFloat(size.height))))
    }
    public class func circleBody(mass: Double, radius: Double, offset: CGPoint?) -> ChipmunkBody {
        return ChipmunkBody(mass: mass, moment: Double(cpMomentForCircle(cpFloat(mass), 0, cpFloat(radius), offset ?? CGPointZero)))
    }
    
    deinit {
        cpBodyFree(self.body)
    }
    
    
    func updatePositionFromNode() {
        self.node?.chipmunk_updateBodyPosition(self)
    }
    func reindexShapes() {
        if let space = self.space {
            cpSpaceReindexShapesForBody(space.space, self.body)
        }
    }
    
    /** forces */
    public func resetForces() {
        cpBodyResetForces(self.body)
    }
    public func applyForce(force: CGPoint) {
        self.applyForce(force, offset: CGPointZero)
    }
    public func applyForce(force: CGPoint,offset: CGPoint) {
        cpBodyApplyForce(self.body, force, offset)
    }
    public func applyImpulse(impulse: CGPoint) {
        self.applyImpulse(impulse, offset: CGPointZero)
    }
    public func applyImpulse(impulse: CGPoint,offset: CGPoint) {
        cpBodyApplyImpulse(self.body, impulse, offset)
    }
    
}