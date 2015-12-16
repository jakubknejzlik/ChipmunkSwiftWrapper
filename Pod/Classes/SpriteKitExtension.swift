//
//  SpriteKitExtension.swift
//  chipmunk-swift-wrapper
//
//  Created by Jakub Knejzlik on 17/11/15.
//  Copyright © 2015 CocoaPods. All rights reserved.
//

import SpriteKit

var SKNodeAssociatedBodyKey: UInt8 = 0
var SKSceneAssociatedSpaceKey: UInt8 = 0

public extension SKNode {
    var chipmunk_body: ChipmunkBody? {
        get {
            return objc_getAssociatedObject(self, &SKNodeAssociatedBodyKey) as? ChipmunkBody
        }
        set(value) {
            objc_setAssociatedObject(self, &SKNodeAssociatedBodyKey, value, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
            
            if let body = value {
                body.node = self
            }
        }
    }
}

extension SKNode: ChipmunkBodyNode {
    
    public func chipmunk_update(interval: NSTimeInterval, delta: NSTimeInterval) {
        if let body = self.chipmunk_body {
            if !body.isStatic {
                self.position = cpvlerp(body.previousPosition ?? body.position, body.position, cpFloat(delta))
                self.zRotation = CGFloat(cpflerp(cpFloat(body.previousAngle ?? body.angle), cpFloat(body.angle), cpFloat(delta)))
            } else {
                self.position = body.position
                self.zRotation = CGFloat(body.angle)
            }
//            print(self.name,body.position,self.position,body.isSleeping,delta,body.shapes)
        }
    }
    
    public func chipmunk_updateBodyPosition(body: ChipmunkBody) {
        if let node = body.space?.data as? SKNode, parentNode = self.parent {
            body.position = node.convertPoint(self.position, fromNode: parentNode)
        }
        body.angle = Double(self.zRotation)
    }
//    func chipmunk_step(interval: NSTimeInterval) {
//        
//    }
//    func chipmunk_step(interval: NSTimeInterval, delta: NSTimeInterval) {
//        
//    }
    func chipmunk_addChild(child: SKNode) {
        self.addChild(child)
        if let body = self.chipmunk_body, space = self.scene?.chipmunk_space {
            space.addObject(body)
        }
    }
}




func addBodiesToSpace(node: SKNode,space: ChipmunkSpace) {
    for children in node.children {
        if let body = children.chipmunk_body {
            space.addObject(body)
        }
        addBodiesToSpace(children, space: space)
    }
}

public extension SKScene {
    var chipmunk_space: ChipmunkSpace? {
        get {
            return objc_getAssociatedObject(self, &SKSceneAssociatedSpaceKey) as? ChipmunkSpace
        }
        set(value) {
            objc_setAssociatedObject(self, &SKSceneAssociatedSpaceKey, value, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
            if let value = value {
                value.data = self
                addBodiesToSpace(self, space: value)
            }
        }
    }
}