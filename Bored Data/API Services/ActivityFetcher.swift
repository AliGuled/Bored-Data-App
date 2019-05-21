//
//  ActivityFetcher.swift
//  Bored Data
//
//  Created by Guled Ali on 4/22/19.
//  Copyright © 2019 Guled Ali. All rights reserved.
//

import Foundation

class ActivityError: Error {
    let message: String
    init(message: String) {
        self.message = message
    }
}


class ActivityFetcher: NSObject {
    
    
    var delegate:ActivityDelegate!
    
    init(delegate: ActivityDelegate) {
        self.delegate = delegate
    }

    
    
   // let urlString = "https://www.boredapi.com/activity/activity?type=recreationalactivity?participants=1"
    // let urlString = "https://www.boredapi.com/activity/activity?type=recreationalactivity?participants=1"
    //let urlString = "https://www.boredapi.com/api/activity?type=recreational"
    let urlString = "https://www.boredapi.com/api/activity/"
    
    //Fetch
    func fetchRandomActivity() {
        
        guard let delegate = delegate else {
            print("Warning -  no delegate set")
            return
        }
        let url = URL(string: urlString)
        let config = URLSessionConfiguration.default
        config.urlCache = nil
        config.requestCachePolicy = .reloadIgnoringLocalAndRemoteCacheData
        let session = URLSession(configuration: config)
        let task = session.dataTask(with: url!,completionHandler: {(data, response,error ) in
            
            if let error = error {
                delegate.activityFetchError(because: ActivityError(message: error.localizedDescription))
            }
            if let data = data {
                let decoder = JSONDecoder()
                
                
                do {
                    let activities = try decoder.decode(Activity.self, from: data)
                    
                        delegate.activityFetched(activity: activities)
                    
                    } catch {
                        delegate.activityFetchError(because: ActivityError(message: "No activity returned"))
                }
                
            }
            
        })
        task.resume()
    }
}
