//
//  Chipmunk.swift
//  Pods
//
//  Created by Jakub Knejzlik on 15/11/15.
//
//

import Foundation

extension Bool {
    init(_ integer: Int32){
        self.init(integer > 0)
    }
    func cpBool() -> Int32 {
        return self ? 1 : 0
    }
}


extension UnsafePointer {
    func getUIntValue() -> UInt {
        let string = "\(self)"//.stringByReplacingOccurrencesOfString("0xb", withString: "").stringByReplacingOccurrencesOfString("0x", withString: "")
        let scanner = NSScanner(string: string)
        var result : UInt64 = 0
        scanner.scanHexLongLong(&result)
        return UInt(result)
    }
}
extension UInt {
    init?(_ pointer: UnsafePointer<Void>) {
        let string = "\(pointer)"//.stringByReplacingOccurrencesOfString("0xb", withString: "").stringByReplacingOccurrencesOfString("0x", withString: "")
        let scanner = NSScanner(string: string)
        var result : UInt64 = 0
        if scanner.scanHexLongLong(&result) {
            print(result) // 37331519
        }
        self = UInt(result)
    }
}