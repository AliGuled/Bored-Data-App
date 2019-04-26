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
    
    @IBOutlet weak var activityTextView: UITextView!
    
    let activityFetcher = ActivityFetcher()
    
    var managedContext: NSManagedObjectContext?
    
    var activityRecord: [ActivityRecord] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
         self.activityFetcher.activityDelegate = self
        let appDelegate = UIApplication.shared.delegate as? AppDelegate
        managedContext = appDelegate?.persistentContainer.viewContext
    }
    
    @IBAction func fetchActivity(_ sender: UIButton) {
        
        activityFetcher.fetchRandomActivity()
        
    }
    
    @IBAction func saveActivity(_ sender: UIButton) {
        var randomActivity: Activity?
        let activy = randomActivity
        let activity = ActivityRecord(context: managedContext!)
        
        activity.activity = activy?.activity
        
        do {
            try managedContext?.save()
        } catch {
            print("Error while saving data")
        }
        
    }
    
    func activityFetched(activity: Activity) {
        
        DispatchQueue.main.async {
            let quoteText = "\(activity.key)- \n\(activity.activity)"
            self.activityTextView.text = quoteText
        }
    }
    
    func activityFetchError(because activityError: ActivityError) {
        DispatchQueue.main.async {
            
            let alert = UIAlertController(title: "Error", message: "Error fetching activity. \(activityError.message)", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Ok", style: .cancel, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
    }
}

