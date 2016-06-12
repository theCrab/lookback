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
    
    var completionHandler: ((location:CLLocation?, error:NSError?)->())?
    
    override init() {
        super.init()
        
        manager = CLLocationManager()
        manager.delegate = self
        manager.desiredAccuracy = kCLLocationAccuracyBest
        manager.distanceFilter = 10
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
    
    func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        // Handle location updates
        for location in locations {
            completionHandler?(location: location, error: nil)
        }
    }
    
    func locationManager(manager: CLLocationManager, didFailWithError error: NSError) {
        completionHandler?(location: nil, error: error)
    }
    
    func authorizationSuccess() {
        manager.startUpdatingLocation()
        NSLog("Already authorized")
    }
    
    func authorizationFailure() {
        NSLog("Background location access disabled")
    }
}