//
//  Coordinate.swift
//  lookback
//
//  Created by Premist on 6/10/16.
//  Copyright © 2016 Premist. All rights reserved.
//

import Foundation
import RealmSwift

// Coordinate Model
class Coordinate: Object {
    dynamic var lat: Float = 0.0;
    dynamic var long: Float = 0.0;
    dynamic var at = NSDate()
}
