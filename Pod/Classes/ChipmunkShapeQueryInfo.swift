//
//  ChipmunkShapeQueryInfo.swift
//  chipmunk-swift-wrapper
//
//  Created by Jakub Knejzlik on 17/11/15.
//  Copyright © 2015 CocoaPods. All rights reserved.
//

import Foundation

public class ChipmunkShapeQueryInfo {
    public let _contacts: cpContactPointSet
    public let shape: ChipmunkShape
    
//    /** The position of the contact point. */
//    func pointForContact(index: Int) -> CGPoint {
//        return self._contacts[index].points.point
//    }
//    /** The normal of the contact point. */
//    -(CGVector)normalForContactAtIndex:(NSInteger)index;
//    /** The depth of the contact point. */
//    -(CGFloat)distanceForContactAtIndex:(NSInteger)index;

    init(shape: UnsafeMutablePointer<cpShape>, contacts: cpContactPointSet) {
        self._contacts = contacts
        self.shape = UnsafeMutablePointer<ChipmunkShape>(cpShapeGetUserData(shape)).memory
        
    }
    
}