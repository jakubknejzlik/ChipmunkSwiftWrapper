//
//  ChipmunkNearestPointQueryInfo.swift
//  chipmunk-swift-wrapper
//
//  Created by Jakub Knejzlik on 17/11/15.
//  Copyright © 2015 CocoaPods. All rights reserved.
//

import Foundation

public class ChipmunkNearestPointQueryInfo {
    let _info: UnsafeMutablePointer<cpNearestPointQueryInfo>
    
    /** The nearest shape, NULL if no shape was within range.*/
    public var shape: ChipmunkShape? {
        return UnsafeMutablePointer<ChipmunkShape>(cpShapeGetUserData(self._info.memory.shape)).memory
    }
    
    /** The closest point on the shape's surface. (in world space coordinates) */
    public var point: CGPoint {
        return CGPointMake(self._info.memory.p.x, self._info.memory.p.y)
    }

    /** The distance to the point. The distance is negative if the point is inside the shape.*/
    public var distance: Double {
        return Double(self._info.memory.d)
    }
        
    init(info: UnsafeMutablePointer<cpNearestPointQueryInfo>) {
        self._info = info
    }
}