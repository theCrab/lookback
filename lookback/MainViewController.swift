//
//  MainViewController.swift
//  lookback
//
//  Created by Premist on 6/6/16.
//  Copyright © 2016 Premist. All rights reserved.
//

import UIKit
import Mapbox
import Firebase
import FirebaseDatabase

class MainViewController: UIViewController,
                      MGLMapViewDelegate {
    
    // MARK: Properties
    var ref: FIRDatabaseReference!
    @IBOutlet weak var mapView: MGLMapView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        ref = FIRDatabase.database().reference()
        
        drawCoordinates()
    }
    
    // Draw coordinates from Firebase database
    func drawCoordinates() {
        let queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0)
        dispatch_async(queue, {
            self.ref.child("coordinates").observeSingleEventOfType(.Value, withBlock: { (snapshot) in
                let coordsDict = snapshot.value as! [String: AnyObject]
                
                for (_, coord) in coordsDict {
                    let coordDict = coord as! [String: Double]
                    
                    let marker = MGLPointAnnotation()
                    marker.coordinate = CLLocationCoordinate2D(latitude: coordDict["latitude"]!, longitude: coordDict["longitude"]!)
                    
                    dispatch_async(dispatch_get_main_queue(), {
                        [unowned self] in self.mapView.addAnnotation(marker)
                    })
                }
            })
        })
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

