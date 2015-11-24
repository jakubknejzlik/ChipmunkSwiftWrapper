//
//  ChipmunkSpace.swift
//  Pods
//
//  Created by Jakub Knejzlik on 15/11/15.
//
//

import Foundation


public typealias PostStepBlock = (space: ChipmunkSpace) -> Void

public typealias BoolCollisionHandler = (arbiter: ChipmunkArbiter, space: ChipmunkSpace) -> Bool
public typealias CollisionHandler = (arbiter: ChipmunkArbiter, space: ChipmunkSpace) -> Void

public struct ChipmunkCollisionBlocks {
    var beginBlock: BoolCollisionHandler?
    var preSolve: BoolCollisionHandler?
    var postSolve: CollisionHandler?
    var separate: CollisionHandler?
    var space: ChipmunkSpace
}


func postStepBlock(space: UnsafeMutablePointer<cpSpace>, key: UnsafeMutablePointer<AnyObject?>, unused: UnsafeMutablePointer<AnyObject?>) {
    let _space = UnsafeMutablePointer<ChipmunkSpace>(cpSpaceGetUserData(space)).memory
    for block in _space.postStepBlocks {
        block(space: _space)
    }
    _space.postStepBlocks.removeAll()
}

func handleBegin(arb: UnsafeMutablePointer<cpArbiter>, space: UnsafeMutablePointer<cpSpace>, data: UnsafeMutablePointer<Void>) -> cpBool {
    let blocks = UnsafeMutablePointer<ChipmunkCollisionBlocks>(data).memory
    if let block = blocks.beginBlock {
        let arbiter = ChipmunkArbiter(arbiter: arb)
        return block(arbiter: arbiter, space: blocks.space) ? 1 : 0
    }
    return 1;
}
func handlePreSolve(arb: UnsafeMutablePointer<cpArbiter>, space: UnsafeMutablePointer<cpSpace>, data: UnsafeMutablePointer<Void>) -> cpBool {
    let blocks = UnsafeMutablePointer<ChipmunkCollisionBlocks>(data).memory
    if let block = blocks.preSolve {
        let arbiter = ChipmunkArbiter(arbiter: arb)
        return block(arbiter: arbiter, space: blocks.space) ? 1 : 0
    }
    return 1;
}
func handlePostSolve(arb: UnsafeMutablePointer<cpArbiter>, space: UnsafeMutablePointer<cpSpace>, data: UnsafeMutablePointer<Void>) -> Void {
    let blocks = UnsafeMutablePointer<ChipmunkCollisionBlocks>(data).memory
    if let block = blocks.postSolve {
        let arbiter = ChipmunkArbiter(arbiter: arb)
        block(arbiter: arbiter, space: blocks.space)
    }
}
func handleSeparate(arb: UnsafeMutablePointer<cpArbiter>, space: UnsafeMutablePointer<cpSpace>, data: UnsafeMutablePointer<Void>) -> Void {
    let blocks = UnsafeMutablePointer<ChipmunkCollisionBlocks>(data).memory
    if let block = blocks.separate {
        let arbiter = ChipmunkArbiter(arbiter: arb)
        block(arbiter: arbiter, space: blocks.space)
    }
}




public class ChipmunkSpace: NSObject {
    var delegate: ChipmunkSpaceDelegate?
    var data: AnyObject?
    
    var lastTimeStamp: CFTimeInterval?
    var currentRepeatInterval: NSTimeInterval?
    var timer: NSTimer?
    var accumulator: Double = 0.0
    
    public var simulationSpeed = 1.0
    public var paused = false
    
    let space: UnsafeMutablePointer<cpSpace>
    
    
    /** Iterations allow you to control the accuracy of the solver. Defaults to 10.*/
    public var iterations: Int32 {
        get {
            return cpSpaceGetIterations(space)
        }
        set(value) {
            cpSpaceSetIterations(space, value)
        }
    }
    
    /** Global gravity applied to the space. Defaults to {0,0}.*/
    public var gravity: CGVector {
        get {
            return CGVectorMake(space.memory.gravity.x, space.memory.gravity.y)
        }
        set(value){
            space.memory.gravity = cpv(cpFloat(value.dx),cpFloat(value.dy))
        }
    }
    
    /** Amount of simple damping to apply to the space. A value of 0.9 means that each body will lose 10% of it’s velocity per second. Defaults to 1.*/
    public var damping: Double {
        get {
            return Double(cpSpaceGetDamping(space))
        }
        set(value) {
            cpSpaceSetDamping(space, cpFloat(value))
        }
    }
    /** Speed threshold for a body to be considered idle. The default value of 0 means to let the space guess a good threshold based on gravity.*/
    public var idleSpeedTreshold: Double {
        get {
            return Double(cpSpaceGetIdleSpeedThreshold(space))
        }
        set(value) {
            cpSpaceSetIdleSpeedThreshold(space, cpFloat(value))
        }
    }
    
    /** Time a group of bodies must remain idle in order to fall asleep. The default value of INFINITY disables the sleeping feature.*/
    public var sleepTimeThreshold: Double {
        get {
            return Double(cpSpaceGetSleepTimeThreshold(space))
        }
        set(value) {
            cpSpaceSetSleepTimeThreshold(space, cpFloat(value))
        }
    }
    /** Amount of overlap between shapes that is allowed. It’s encouraged to set this as high as you can without noticable overlapping as it improves the stability. It defaults to 0.1.*/
    public var collisionSlop: Double {
        get {
            return Double(cpSpaceGetCollisionSlop(space))
        }
        set(value) {
            cpSpaceSetCollisionSlop(space, cpFloat(value))
        }
    }

    deinit {
        cpSpaceDestroy(self.space)
    }
    /**
    * Chipmunk allows fast moving objects to overlap, then fixes the overlap over time. Overlapping objects are unavoidable even if swept collisions are supported, and this is an efficient and stable way to deal with overlapping objects.
    * The bias value controls what percentage of overlap remains unfixed after a second and defaults to ~0.2%. Valid values are in the range from 0 to 1, but using 0 is not recommended for stability reasons.
    * The default value is calculated as cpfpow(1.0f - 0.1f, 60.0f) meaning that Chipmunk attempts to correct 10% of error ever 1/60th of a second. Note: Very very few games will need to change this value.
    */
    public var collisionBias: Double {
        get {
            return Double(cpSpaceGetCollisionBias(space))
        }
        set(value) {
            cpSpaceSetCollisionBias(space, cpFloat(value))
        }
    }
    /** The number of frames the space keeps collision solutions around for. Helps prevent jittering contacts from getting worse. This defaults to 3 and very very very few games will need to change this value.*/
    public var collisionPersistence: UInt32 {
        get {
            return cpSpaceGetCollisionPersistence(space)
        }
        set(value) {
            cpSpaceSetCollisionPersistence(space, value)
        }
    }
    /** Retrieves the current (if you are in a callback from cpSpaceStep()) or most recent (outside of a cpSpaceStep() call) timestep.*/
    public var currentTimeStep: Double {
        return Double(cpSpaceGetCurrentTimeStep(space))
    }
    
    var objects: Set<ChipmunkSpaceObject> = []
    var bodies: Set<ChipmunkBody> = []
    var postStepBlocks: Array<PostStepBlock> = []
    var collisionHandlerBlocks: Array<ChipmunkCollisionBlocks> = []
    
    public override init() {
        space = cpSpaceNew()
        super.init()

        let pointer = UnsafeMutablePointer<Void>(unsafeAddressOf(self))
        cpSpaceSetUserData(space, pointer)
        self.gravity = CGVectorMake(0, -100)
    }
    
    
    public convenience init(boundaries: CGRect) {
        self.init()
        self.addBoundary(CGPointMake(CGRectGetMinX(boundaries), CGRectGetMinY(boundaries)), to:CGPointMake(CGRectGetMaxX(boundaries), CGRectGetMinY(boundaries)))
        self.addBoundary(CGPointMake(CGRectGetMinX(boundaries), CGRectGetMaxY(boundaries)), to:CGPointMake(CGRectGetMaxX(boundaries), CGRectGetMaxY(boundaries)))
        self.addBoundary(CGPointMake(CGRectGetMinX(boundaries), CGRectGetMinY(boundaries)), to:CGPointMake(CGRectGetMinX(boundaries), CGRectGetMaxY(boundaries)))
        self.addBoundary(CGPointMake(CGRectGetMaxX(boundaries), CGRectGetMinY(boundaries)), to:CGPointMake(CGRectGetMaxX(boundaries), CGRectGetMaxY(boundaries)))
        
    }
    
    public func addBoundary(from: CGPoint, to: CGPoint) {
        let ground = cpSegmentShapeNew(self.space.memory.staticBody, from,to, 0);
        cpShapeSetFriction(ground, 1);
        cpShapeSetElasticity(ground, 1);
        cpSpaceAddStaticShape(self.space, ground);
    }
    
    
    /** Automatic simulation */
    
    public func startSimulation(repeatInterval: NSTimeInterval) {
        self.currentRepeatInterval = repeatInterval
        self.timer = NSTimer.scheduledTimerWithTimeInterval(repeatInterval, target: self, selector: "tick", userInfo: nil, repeats: true)
    }
    
    public func step(step: NSTimeInterval, updateNodes: Bool = true) {
        if self.paused {
            return
        }
        for body in self.bodies {
            if let node = body.node {
                body.previousPosition = body.position
                body.previousAngle = body.angle
                node.chipmunk_update(step, delta: step)
            }
        }
        cpSpaceStep(self.space, cpFloat(step))
        if updateNodes {
            self.updateBodies(step, repeatInterval: self.currentRepeatInterval ?? 0)
        }
    }
    
    public func tick() {
        let currentRepeatInterval = self.currentRepeatInterval ?? 1.0/60.0
        if self.lastTimeStamp == nil {
            self.lastTimeStamp = CACurrentMediaTime()
        } else {
            let newTimeStamp = CACurrentMediaTime()
            let dt = currentRepeatInterval
            let frameTime = min((newTimeStamp - (self.lastTimeStamp ?? newTimeStamp)) * self.simulationSpeed,dt * 10)
            self.accumulator += frameTime
            while (self.accumulator > dt) {
                self.step(dt, updateNodes: false)
                accumulator -= dt
            }
            self.updateBodies(1-accumulator/dt, repeatInterval: currentRepeatInterval)
            self.lastTimeStamp = newTimeStamp
        }
    }
    
    
    public func addPostStepBlock(block: PostStepBlock) {
        self.postStepBlocks.append(block)
    }
    public func addCollisionHandler(typeA typeA: AnyObject, typeB: AnyObject, begin: BoolCollisionHandler? = nil, preSolve: BoolCollisionHandler? = nil, postSolve: CollisionHandler? = nil, separate: CollisionHandler? = nil) {
        let collisionBlocks = ChipmunkCollisionBlocks(beginBlock: begin, preSolve: preSolve, postSolve: postSolve, separate: separate,space: self)
        self.collisionHandlerBlocks.append(collisionBlocks)
        let pointer = withUnsafeMutablePointer(&self.collisionHandlerBlocks[self.collisionHandlerBlocks.count - 1], { $0 }) // must take reference from self.collisionHandlerBlocks
//        print("add collision handler",unsafeAddressOf(typeA),unsafeAddressOf(typeB),unsafeAddressOf(typeA).getUIntValue(),unsafeAddressOf(typeB).getUIntValue())
        cpSpaceAddCollisionHandler(self.space, unsafeAddressOf(typeA).getUIntValue(), unsafeAddressOf(typeB).getUIntValue(), handleBegin, handlePreSolve, handlePostSolve, handleSeparate, pointer)
    }
    
    
    public func addObject(object: ChipmunkSpaceObject) -> ChipmunkSpaceObject {
        object.space = self
        self.objects.insert(object)
        if let object = object as? ChipmunkBody {
            self.bodies.insert(object)
        }
        return object
    }
    public func removeObject(object: ChipmunkSpaceObject) {
        object.space = nil
        self.objects.remove(object)
        if let object = object as? ChipmunkBody {
            self.bodies.remove(object)
        }
    }
    public func postStepRemoveObject(object: ChipmunkSpaceObject) {
        self.addPostStepBlock { (space: ChipmunkSpace) -> Void in
            space.removeObject(object)
        }
    }
    
    public func updateBodies(delta: NSTimeInterval, repeatInterval: NSTimeInterval) {
        for body in self.bodies {
            if let node = body.node {
                node.chipmunk_update(repeatInterval, delta: delta)
            }
        }
    }
}

protocol ChipmunkSpaceDelegate {
    
}

