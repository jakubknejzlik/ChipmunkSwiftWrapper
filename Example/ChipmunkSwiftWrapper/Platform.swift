//
//  Platform.swift
//  ChipmunkSwiftWrapper
//
//  Created by Jakub Knejzlik on 17/11/15.
//  Copyright © 2015 CocoaPods. All rights reserved.
//

import SpriteKit
import ChipmunkSwiftWrapper

class Platform: SKSpriteNode {
    static let collisionType: UInt = 2
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        let platformBody = ChipmunkBody.staticBody()
        let platformBox = ChipmunkShape(body: platformBody, size: self.size)
        platformBox.elasticity = 1
        platformBox.friction = 0.2
        platformBox.collisionType = Platform.self
        //            print(platformBox)
        //            platformBody.addShape(platformBox)
        self.chipmunk_body = platformBody
    }
}