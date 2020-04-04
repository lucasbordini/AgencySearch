//
//  Location.swift
//  AgencySearch
//
//  Created by Lucas Bordini Ribeiro de Araujo on 03/04/20.
//  Copyright © 2020 Lucas Bordini Ribeiro de Araujo. All rights reserved.
//

import Foundation

struct Location {
    let latitude: Double
    let longitude: Double
}

extension Location: Codable {
    
    enum CodingKeys: String, CodingKey {
        case latitude = "lat"
        case longitude = "lng"
    }
}
