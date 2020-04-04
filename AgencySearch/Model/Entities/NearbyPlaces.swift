//
//  NearbyPlacesCandidates.swift
//  AgencySearch
//
//  Created by Lucas Bordini Ribeiro de Araujo on 03/04/20.
//  Copyright © 2020 Lucas Bordini Ribeiro de Araujo. All rights reserved.
//

import Foundation

struct NearbyPlaces {
    
    let geometry: Geometry
    let name: String
    let id: String
    let placeId: String
}

extension NearbyPlaces: Codable {
    
    enum CodingKeys: String, CodingKey {
        case placeId = "place_id"
        case name
        case id
        case geometry
    }
}

extension NearbyPlaces: Equatable {
    static func == (lhs: NearbyPlaces, rhs: NearbyPlaces) -> Bool {
        return lhs.id == rhs.id
    }
    
    
    
}
