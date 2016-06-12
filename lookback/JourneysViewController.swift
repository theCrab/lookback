//
//  JourneysViewController.swift
//  
//
//  Created by Premist on 6/12/16.
//
//

import UIKit
import RealmSwift

class JourneysViewController: UITableViewController {
    var journeys: Results<Journey>?
    let realm = try! Realm()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        journeys = Journey.all()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func showNewJourneyAlert(sender: AnyObject) {
        let alertController = UIAlertController(title: "Add New Journey", message: "Enter name of the journey below.", preferredStyle: UIAlertControllerStyle.Alert)
        
        let createAction = UIAlertAction(title: "Create", style: UIAlertActionStyle.Default, handler: { alert -> Void in
            let textField = alertController.textFields![0] as UITextField
            
            self.createNewJourney(textField.text!)
        })
        
        let cancelAction = UIAlertAction(title: "Cancel", style: UIAlertActionStyle.Cancel, handler: { alert -> Void in
        })
        
        alertController.addTextFieldWithConfigurationHandler({ (textField: UITextField!) -> Void in
            textField.placeholder = "Enter Journey Name"
        })
        
        alertController.addAction(cancelAction)
        alertController.addAction(createAction)
        
        self.presentViewController(alertController, animated: true, completion: nil)
    }
    
    @IBAction func dismissCurrentView() {
        self.presentingViewController!.dismissViewControllerAnimated(true, completion: nil)
    }

    // MARK: - Table view data source
    
    func createNewJourney(title: String) {
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), {
            let realm = try! Realm()
            
            let journey = Journey(value: [title, List<Coordinate>()])
            try! realm.write() { realm.add(journey) }
            
            dispatch_async(dispatch_get_main_queue(), {
                [unowned self] in self.tableView.reloadData()
            })
        })
    }
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return journeys!.count
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("JourneyCell", forIndexPath: indexPath)

        let journey = journeys![indexPath.row] as Journey
        
        cell.textLabel?.text = journey.name
        cell.detailTextLabel?.text = "\(journey.coordinates.count) Coordinates"
        // Configure the cell...

        return cell
    }

    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
