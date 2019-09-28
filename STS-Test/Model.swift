//
//  Notice.swift
//  STS-Test
//
//  Created by Artem on 28/09/2019.
//  Copyright © 2019 temi4hik. All rights reserved.
//
import Foundation


/// If we want use some class in App,
/// then it should implement Base protocol.
/// The only requirement is to implement required init
///
/// Unfortunately because of reflection and objc runtime
/// only classes are supported
protocol Base: class {
    init()
    
    func setRandomFields() -> Void
}

extension Base {
    /// Default implementation
    func setRandomFields() -> Void {}
    
    func typeStr() -> String {
        let t = type(of: self)
        return String(describing: t)
    }
}

class Notice: Base {
    var flightDate: Date?
    var gate: String?
    
    required init() {}
    
    func setRandomFields() {
        self.flightDate = Date(timeIntervalSinceNow: TimeInterval(Int.random(in: 10000...50000)))
        let gates = ["A", "B", "C", "D", "E", "F", "G"]
        self.gate = gates.randomElement()!
    }
}

class Event: Base {
    var startTime: Date?
    var endTime: Date?
    var name: String!
    
    required init() {}
    
    func setRandomFields() {
        self.startTime = Date(timeIntervalSinceNow: TimeInterval(Int.random(in: -10000...10000)))
        self.endTime = Date(timeIntervalSinceNow: TimeInterval(Int.random(in: 10500...20000)))
        let events = ["Birthday", "Exam", "Holiday", "New year", "D-Day"]
        self.name = events.randomElement()!
    }
}

class Move: Base {
    var fromPlace: String?
    var toPlace: String?
    var estimateTime: TimeInterval?
    
    required init() {}
    
    func setRandomFields() {
        let places = ["School", "Home", "Club", "Shop", "Railroad", "Airport", "Apple Store", "University"]
        self.fromPlace = places.randomElement()!
        self.toPlace = places.randomElement()!
        
        if self.fromPlace == self.toPlace {
            self.estimateTime = TimeInterval(0.0)
        } else {
            self.estimateTime = TimeInterval(Int.random(in: 100...2000))
        }
    }
}
