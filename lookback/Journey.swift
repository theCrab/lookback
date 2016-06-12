//
//  Journey.swift
//  lookback
//
//  Created by Premist on 6/12/16.
//  Copyright © 2016 Premist. All rights reserved.
//

import Foundation
import RealmSwift

class Journey: Object {
    
    dynamic var name = ""
    let coordinates = List<Coordinate>()
    
// Specify properties to ignore (Realm won't persist these)
    
//  override static func ignoredProperties() -> [String] {
//    return []
//  }
    
    static private let realm = try! Realm()
    
    class func all() -> Results<Journey> {
        return realm.objects(Journey.self)
    }
}
