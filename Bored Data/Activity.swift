//
//  Activity.swift
//  Bored Data
//
//  Created by Guled Ali on 4/22/19.
//  Copyright © 2019 Guled Ali. All rights reserved.
//

import Foundation

struct Activity: Decodable {
    
    let activity: String
    let accessibility: Float
    let type: String
    let participants: Int
    let price: Float
    let key: Int
    
    enum CodingKeys: String, CodingKey {
        case activity = "activity"
        case accessibility = "content"
        case type = "type"
        case participants = "participants"
        case price = "price"
        case key = "key"
    }
}

