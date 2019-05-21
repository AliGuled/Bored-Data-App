//
//  Activity.swift
//  Bored Data
//
//  Created by Guled Ali on 4/22/19.
//  Copyright © 2019 Guled Ali. All rights reserved.
//

import Foundation

struct Results: Decodable {
    let results: Activity
    
}

struct Activity: Decodable {
    let activity: String
  
    
    
    //Source: https://stackoverflow.com/questions/49675026/coding-key-difficulties-with-json-swift-4-1
    enum CodingKeys: String, CodingKey {
        case activity
        
        
    }
  
}

