//
//  Coordinate.swift
//  lookback
//
//  Created by Premist on 6/12/16.
//  Copyright © 2016 Premist. All rights reserved.
//

import Foundation
import RealmSwift

class Coordinate: Object {
    dynamic var latitude: Float = 0.0
    dynamic var longitude: Float = 0.0
    dynamic var value = NSDate()
    
// Specify properties to ignore (Realm won't persist these)
    
//  override static func ignoredProperties() -> [String] {
//    return []
//  }
}
