//
//  GameScene.swift
//  chipmunk-swift-wrapper
//
//  Created by Jakub Knejzlik on 17/11/15.
//  Copyright © 2015 CocoaPods. All rights reserved.
//

import SpriteKit

import ChipmunkSwiftWrapper

class GameScene: SKScene {
    override func didMoveToView(view: SKView) {
        let space = ChipmunkSpace(boundaries: self.frame)
//        space.simulationSpeed = 10
        self.chipmunk_space = space
        
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
        
        space.startSimulation(1.0/60.0)
        space.step(1)
        
        space.addCollisionHandler(typeA: Asteroid.self, typeB: Platform.self, begin: { (arbiter, space) -> Bool in
            print("begin")
            return true
        }, preSolve: { (arbiter, space) -> Bool in
            print("presolve")
            return true
        }, postSolve: { (arbiter, space) in
            print("postSolve")
        }, separate: { (arbiter, space) in
            print("separate")
        })
    }
    
}