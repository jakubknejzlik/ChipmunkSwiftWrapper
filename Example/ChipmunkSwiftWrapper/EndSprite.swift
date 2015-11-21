//
//  EndSprite.swift
//  ChipmunkSwiftWrapper
//
//  Created by Jakub Knejzlik on 21/11/15.
//  Copyright © 2015 CocoaPods. All rights reserved.
//

import SpriteKit

import ChipmunkSwiftWrapper

class EndSprite: SKSpriteNode {
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        let body = ChipmunkBody.staticBody()
        let box = ChipmunkShape(body: body, size: self.size)
        box.elasticity = 1
        box.friction = 0.2
        box.collisionType = EndSprite.self
        box.group = EndSprite.self
        self.chipmunk_body = body
    }
}