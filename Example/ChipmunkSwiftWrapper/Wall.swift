//
//  Platform.swift
//  ChipmunkSwiftWrapper
//
//  Created by Jakub Knejzlik on 17/11/15.
//  Copyright © 2015 CocoaPods. All rights reserved.
//

import SpriteKit
import ChipmunkSwiftWrapper

class Wall: SKSpriteNode {
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        let platformBody = ChipmunkBody.staticBody()
        let platformBox = ChipmunkShape(body: platformBody, size: self.size)
        platformBox.elasticity = 1
        platformBox.friction = 0.2
        platformBox.collisionType = Wall.self
        self.chipmunk_body = platformBody
        
        // this is veery slow, don't use this approach in-game
        UIGraphicsBeginImageContext(self.size)
        let context = UIGraphicsGetCurrentContext();
        CGContextDrawTiledImage(context, CGRectMake(0, 0, self.size.width, self.size.height), UIImage(named: "wall")?.CGImage)
        let tiledBackground = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        let texture = SKTexture(image: tiledBackground)
        
        let changeTexture = SKAction.setTexture(texture)
        self.runAction(changeTexture)
        print(self.texture)
        
    }
}