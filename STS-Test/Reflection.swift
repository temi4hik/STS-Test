//
//  Reflection.swift
//  STS-Test
//
//  Created by Artem on 28/09/2019.
//  Copyright © 2019 temi4hik. All rights reserved.
//

import Foundation

private func withAllClasses<R>(_ body: (UnsafeBufferPointer<AnyClass>) throws -> R) rethrows -> R {
    var count: UInt32 = 0
    let classListPtr = objc_copyClassList(&count)
    
    defer {
        free(UnsafeMutableRawPointer(classListPtr))
    }
    
    let classListBuffer = UnsafeBufferPointer(start: classListPtr, count: Int(count))
    
    return try body(classListBuffer)
}


func getClasses() -> [Base.Type] {
    let classes = withAllClasses { $0.compactMap { $0 as? Base.Type } }
    
    return classes
}


extension Base {
    func fieldsList() -> [String] {
        let mirror = Mirror(reflecting: self)
        var fields: [String] = []
        
        for child in mirror.children {
            if let label = child.label {
                fields.append(label)
            }
        }
        
        return fields
    }
    
    func allFields() -> [String : Any?] {
        let mirror = Mirror(reflecting: self)
        var fields: [String : Any] = [String : Any]()
        
        for child in mirror.children {
            if let label = child.label {
                fields[label] = child.value
            }
        }
        
        return fields
    }
}
