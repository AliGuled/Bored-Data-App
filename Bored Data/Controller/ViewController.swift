//
//  ViewController.swift
//  Bored Data
//
//  Created by Guled Ali on 4/22/19.
//  Copyright © 2019 Guled Ali. All rights reserved.
//

import UIKit
import CoreData

class ViewController: UIViewController,ActivityDelegate {
    
    //Activit
    @IBOutlet weak var activityTextView: UITextView!
    
    //Subclass of ActivityFetcher
    var fetch: ActivityFetcher!
   

    
    //Core Data context
    var managedContext: NSManagedObjectContext?
    
    //Array of Activity Record
    var activityRecord: [ActivityRecord] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let appDelegate = UIApplication.shared.delegate as? AppDelegate
        managedContext = appDelegate?.persistentContainer.viewContext
        
    }
    
    //Fetching Activity
    @IBAction func fetchActivity(_ sender: UIButton) {
       
        if fetch != nil {
            fetch.fetchRandomActivity()
        }
    }
    

    //Saving activity in core data
    @IBAction func saveActivity(_ sender: UIButton) {
        var randomActivity: Activity!
        let activy = randomActivity
        let activity = ActivityRecord(context: managedContext!)
        
        activity.activity = activy?.activity
        
        do {
            try managedContext?.save()
        } catch {
            print("Error while saving data")
        }
        
    }
    
    //Display the activity in textview
    func activityFetched(activity: Activity) {
        
        DispatchQueue.main.async {
            let activityText = "\(activity.activity)"
            self.activityTextView.text = activityText
            print("fetched")
        }
    }
    
    //Responding if there is no activity found
    func activityFetchError(because activityError: ActivityError) {
        DispatchQueue.main.async {
            
            let alert = UIAlertController(title: "Error", message: "Error fetching activity. \(activityError.message)", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Ok", style: .cancel, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
    }
}

