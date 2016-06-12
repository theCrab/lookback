//
//  MainViewController.swift
//  lookback
//
//  Created by Premist on 6/6/16.
//  Copyright © 2016 Premist. All rights reserved.
//

import UIKit
import Mapbox
import MapKit

class MainViewController: UIViewController,
                      MGLMapViewDelegate {
    
    @IBOutlet weak var mapView: MGLMapView!
    
    var coordinates = [CLLocationCoordinate2D]()
    var polylines = [MGLPolyline]()
    
    private var startedInitialCamerawork: Bool = false
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
        centerCurrentLocation(location.coordinate)
        
        coordinates.append(location.coordinate)
        
        let polyline = currentPolyline()
        mapView.addAnnotation(polyline)
        polylines.append(polyline)
        
        if polylines.count > 2 {
            mapView.removeAnnotation(polylines[0])
            polylines.removeAtIndex(0)
        }
    }
    
    func centerCurrentLocation(currentCoordinate: CLLocationCoordinate2D) {
        guard finishedInitialCamerawork == true else { return }
        
        let previousPoint = MKMapPointForCoordinate(mapView.centerCoordinate)
        let currentPoint = MKMapPointForCoordinate(currentCoordinate)
        
        guard MKMetersBetweenMapPoints(previousPoint, currentPoint) > 100 else { return }
        
        mapView.setCenterCoordinate(currentCoordinate, animated: true)
    }
    
    func performInitialCamerawork(coordinate: CLLocationCoordinate2D) {
        guard startedInitialCamerawork == false else { return }
        
        let camera = MGLMapCamera(lookingAtCenterCoordinate: coordinate, fromDistance: 6000, pitch: 30, heading: 20)
        mapView.flyToCamera(camera, withDuration: 15, completionHandler: {
            NSLog("Finished camera work")
            self.finishedInitialCamerawork = true
        })
        
        startedInitialCamerawork = true
    }
}