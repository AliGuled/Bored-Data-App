//
//  ActivityDelegate.swift
//  Bored Data
//
//  Created by Guled Ali on 4/22/19.
//  Copyright © 2019 Guled Ali. All rights reserved.
//

import Foundation


protocol ActivityDelegate {
    func activityFetched(activity: Activity)
    func activityFetchError(because activityError: ActivityError)
    
}
