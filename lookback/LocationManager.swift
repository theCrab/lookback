//
//  LocationManager.swift
//  lookback
//
//  Created by Premist on 6/12/16.
//  Copyright © 2016 Premist. All rights reserved.
//
//  Heavily inspired by https://github.com/varshylmobile/LocationManager

import Foundation
import CoreLocation
import UIKit

class LocationManager: NSObject, CLLocationManagerDelegate {
    static let sharedInstance = LocationManager()
    var manager: CLLocationManager!
    
    override init() {
        super.init()
        
        manager = CLLocationManager()
        manager.delegate = self
    }
    
    func start() {
        validateAuthorization(CLLocationManager.authorizationStatus())
    }
    
    func locationManager(manager: CLLocationManager, didChangeAuthorizationStatus status: CLAuthorizationStatus) {
        validateAuthorization(status)
    }
    
    func validateAuthorization(status: CLAuthorizationStatus) {
        switch status {
        case .AuthorizedAlways:
            authorizationSuccess()
        case .NotDetermined:
            manager.requestAlwaysAuthorization()
        case .AuthorizedWhenInUse, .Restricted, .Denied:
            authorizationFailure()
            
        }
    }
    
    func authorizationSuccess() {
        NSLog("Already authorized")
    }
    
    func authorizationFailure() {
        NSLog("Background location access disabled")
    }
}