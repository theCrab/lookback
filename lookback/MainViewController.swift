//
//  MainViewController.swift
//  lookback
//
//  Created by Premist on 6/6/16.
//  Copyright © 2016 Premist. All rights reserved.
//

import UIKit
import Mapbox

class MainViewController: UIViewController,
                      MGLMapViewDelegate {
    
    @IBOutlet weak var mapView: MGLMapView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        mapView.showsUserLocation = true
        self.startUpdatingLocations()
        
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func startUpdatingLocations() {
        LocationManager.sharedInstance.completionHandler = { (location, error) in
            guard error == nil else { return }
            self.updateLocationOnMapView(location!)
            
        }
        
        LocationManager.sharedInstance.start()
    }
    
    func updateLocationOnMapView(location: CLLocation) {
        mapView.setCenterCoordinate(location.coordinate, zoomLevel: 15, direction: 0, animated: true)
    }
}

