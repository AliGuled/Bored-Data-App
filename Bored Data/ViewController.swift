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
    func activityFetched(activity: Activity) {
        
        DispatchQueue.main.async {
            let quoteText = "\(activity.key)- \n\(activity.activity)"
            self.activityTextView.text = quoteText
    }
    }
    
    func activityFetchError(because activityError: ActivityError) {
        let alert = UIAlertController(title: "Error", message: "Error fetching activity. \(activityError.message)", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .cancel, handler: nil))
        present(alert, animated: true, completion: nil)
    }
    
    @IBOutlet weak var activityTextView: UITextView!
    
    let activityFetcher = ActivityFetcher()
    
    var managedContext: NSManagedObjectContext?
    
    var activityRecord: [ActivityRecord] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        DispatchQueue.main.async {
            
        
        // Do any additional setup after loading the view.
            self.activityFetcher.activityDelegate = self
            self.activityFetcher.fetchRandomActivity()
    }
    }

    @IBAction func fetchActivity(_ sender: UIButton) {
        activityFetcher.fetchRandomActivity()
    }
    
}

