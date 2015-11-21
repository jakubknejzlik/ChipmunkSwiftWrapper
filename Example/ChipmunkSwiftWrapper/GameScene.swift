//
//  GameScene.swift
//  chipmunk-swift-wrapper
//
//  Created by Jakub Knejzlik on 17/11/15.
//  Copyright © 2015 CocoaPods. All rights reserved.
//

import SpriteKit
import UIKit

import ChipmunkSwiftWrapper
import CoreMotion

class GameScene: SKScene {
    let manager = CMMotionManager()
    override func didMoveToView(view: SKView) {
        let space = ChipmunkSpace(boundaries: self.frame)
//        space.simulationSpeed = 10
        self.chipmunk_space = space
        space.gravity = CGVectorMake(0, 0)
        space.damping = 1
        
//        if let node = self.childNodeWithName("node") as? SKSpriteNode, platform = self.childNodeWithName("platform") as? SKSpriteNode {
//            if let body = node.chipmunk_body {
//                space.addObject(body)
//            }
//            let platformBody = ChipmunkBody.staticBody()
//            let platformBox = ChipmunkShape(body: platformBody, size: platform.size)
//            platformBox.elasticity = 1
////            print(platformBox)
////            platformBody.addShape(platformBox)
//            platform.chipmunk_body = platformBody
//            space.addObject(platformBody)
//        }
        
        self.manager.accelerometerUpdateInterval = 0.05
        self.manager.startAccelerometerUpdatesToQueue(NSOperationQueue.mainQueue()) { (data, error) -> Void in
            if let data = data {
                space.gravity = CGVectorMake(CGFloat(-data.acceleration.y)*5000, CGFloat(data.acceleration.x)*5000)
            } else {
                space.gravity = CGVectorMake(0, 0)
            }
        }
        
        
//        space.startSimulation(1.0/100.0)
//        space.step(1)
        
        space.addCollisionHandler(typeA: Ball.self, typeB: EndSprite.self, begin: { (arbiter, space) -> Bool in
            if let controller = view.window?.rootViewController {
                let alert = UIAlertController(title: "Good job!", message: "You've made it to the end.", preferredStyle: .Alert)
                alert.addAction(UIAlertAction(title: "OK", style: .Cancel, handler: { (action) -> Void in
                    controller.dismissViewControllerAnimated(true, completion: nil)
                    space.paused = false
                }))
                controller.presentViewController(alert, animated: true, completion: nil)
            }
            space.paused = true
            return false
        }, preSolve: { (arbiter, space) -> Bool in
            print("presolve")
            return true
        }, postSolve: { (arbiter, space) in
            print("postSolve")
        }, separate: { (arbiter, space) in
            print("separate")
        })
    }
    
    override func update(currentTime: NSTimeInterval) {
        self.chipmunk_space?.tick()
    }
    
}