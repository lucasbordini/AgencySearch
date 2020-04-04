//
//  Photos.swift
//  AgencySearch
//
//  Created by Lucas Bordini Ribeiro de Araujo on 03/04/20.
//  Copyright © 2020 Lucas Bordini Ribeiro de Araujo. All rights reserved.
//

import Foundation

struct Photos {
    let photoReference: String
}

extension Photos: Codable {
    enum CodingKeys: String, CodingKey {
        case photoReference = "photo_reference"
    }
}
