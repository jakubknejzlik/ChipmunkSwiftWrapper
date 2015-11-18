//
//  ChipmunkSegmentQueryInfo.swift
//  chipmunk-swift-wrapper
//
//  Created by Jakub Knejzlik on 17/11/15.
//  Copyright © 2015 CocoaPods. All rights reserved.
//

import Foundation

public class ChipmunkSegmentQueryInfo {
    let _queryInfo: cpSegmentQueryInfo
    
    /** The shape that was hit, NULL if no collision occured. */
    public var shape: ChipmunkShape {
        return UnsafeMutablePointer<ChipmunkShape>(cpShapeGetUserData(self._queryInfo.shape)).memory
    }
    /** The normalized distance along the query segment in the range [0, 1]. */
    public var normalizedDistance: Double {
        return Double(self._queryInfo.t)
    }
    /** The normal of the surface hit. */
    public var normal: CGPoint {
        return CGPointMake(self._queryInfo.n.x, self._queryInfo.n.y)
    }

    init(queryInfo: cpSegmentQueryInfo) {
        self._queryInfo = queryInfo
    }
    
    convenience init(shape: UnsafeMutablePointer<cpShape>, normalizedDistance: Double, normal: CGPoint) {
        let info = cpSegmentQueryInfo(shape: shape, t: cpFloat(normalizedDistance), n: normal)
        self.init(queryInfo: info)
    }
}