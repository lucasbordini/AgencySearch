//
//  Location.swift
//  AgencySearch
//
//  Created by Lucas Bordini Ribeiro de Araujo on 01/04/20.
//  Copyright © 2020 Lucas Bordini Ribeiro de Araujo. All rights reserved.
//

import Foundation

struct Places {
    
    let candidates: [NearbyPlaces]
    let errorMessage: String?
    let status: String
    
}

extension Places: Codable {
    
    enum CodingKeys: String, CodingKey {
        case errorMessage = "error_message"
        case candidates
        case status
    }
}
