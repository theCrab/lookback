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
    var coordinates = [CLLocationCoordinate2D]()
    
    private var finishedInitialCamerawork: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        mapView.showsUserLocation = true
        mapView.delegate = self
        
        self.startUpdatingLocations()
        
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func mapViewDidFinishLoadingMap(mapView: MGLMapView) {
    }
    
    func currentPolyline() -> MGLPolyline {
        return MGLPolyline(coordinates: &coordinates, count: UInt(coordinates.count))
    }

    func startUpdatingLocations() {
        LocationManager.sharedInstance.completionHandler = { (location, error) in
            guard error == nil else { return }
            self.processLocation(location!)
            
        }
        
        LocationManager.sharedInstance.start()
    }
    
    func processLocation(location: CLLocation) {
        performInitialCamerawork(location.coordinate)
        coordinates.append(location.coordinate)
        mapView.addAnnotation(currentPolyline())
    }
    
    func performInitialCamerawork(coordinate: CLLocationCoordinate2D) {
        guard finishedInitialCamerawork == false else { return }
        
        let camera = MGLMapCamera(lookingAtCenterCoordinate: coordinate, fromDistance: 2000, pitch: 15, heading: 0)
        mapView.flyToCamera(camera, withDuration: 15, completionHandler: { NSLog("Finished camera work") })
        
        finishedInitialCamerawork = true
    }
}

