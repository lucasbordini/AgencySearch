//
//  PlaceDetailCandidates.swift
//  AgencySearch
//
//  Created by Lucas Bordini Ribeiro de Araujo on 03/04/20.
//  Copyright © 2020 Lucas Bordini Ribeiro de Araujo. All rights reserved.
//

import Foundation
import UIKit.UIImage

struct PlaceDetail {
    let formattedAddress: String
    let formattedPhoneNumber: String
    let name: String
    let openingHours: OpeningHours
    let photos: [Photos]
}

extension PlaceDetail: Codable {
    
    enum CodingKeys: String, CodingKey {
        case formattedAddress = "formatted_address"
        case formattedPhoneNumber = "formatted_phone_number"
        case openingHours = "opening_hours"
        case name
        case photos
    }
}
