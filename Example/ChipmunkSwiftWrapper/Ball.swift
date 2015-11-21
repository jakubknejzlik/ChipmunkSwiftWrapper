//
//  Asteroid.swift
//  ChipmunkSwiftWrapper
//
//  Created by Jakub Knejzlik on 17/11/15.
//  Copyright © 2015 CocoaPods. All rights reserved.
//

import SpriteKit
import ChipmunkSwiftWrapper

class Ball: SKSpriteNode {
    static let collisionType: UInt = 1
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        let radius = Double(self.size.width)/2.0
        let body = ChipmunkBody.circleBody(1000, radius: radius, offset:  CGPointZero)
        let box = ChipmunkShape(body: body, radius: radius, offset: CGPointZero)
        box.elasticity = 0.2
        box.friction = 0
        box.collisionType = Ball.self
        box.group = Ball.self
        //
        ////            body.addShape(box)
        self.chipmunk_body = body
        //        space.addObject(body)
    }
}