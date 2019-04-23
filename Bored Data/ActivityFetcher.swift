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

class ActivityFetcher {
    
    var activityDelegate: ActivityDelegate?
    
    
    let urlString = "https://www.boredapi.com/api/activity/"
    
    func fetchRandomActivity() {
        
        guard let delegate = activityDelegate else {
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
            if let activityData = data {
                let decoder = JSONDecoder()
                if let data = data {
                    let activities = try? decoder.decode([Activity].self, from: data)
                    if let randomQuote = activities?.first {
                        delegate.activityFetched(activity: randomQuote)
                    } else {
                        delegate.activityFetchError(because: ActivityError(message: "No activity returned"))
                    }
                    
                } else {
                    delegate.activityFetchError(because: ActivityError(message: "Unable to decode response from quote server"))
                }
                
            }
            
            
        })
        task.resume()
    }
}
