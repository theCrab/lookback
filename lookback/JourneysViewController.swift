//
//  JourneysViewController.swift
//  lookback
//
//  Created by Premist on 6/12/16.
//  Copyright © 2016 Premist. All rights reserved.
//

import UIKit

class JourneysViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func dismissCurrentView() {
        self.presentingViewController!.dismissViewControllerAnimated(true, completion: nil)
    }
    
}