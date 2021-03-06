//
//  PlaceDetailsResponse.swift
//  AgencySearch
//
//  Created by Lucas Bordini Ribeiro de Araujo on 03/04/20.
//  Copyright © 2020 Lucas Bordini Ribeiro de Araujo. All rights reserved.
//

import Foundation

struct PlaceDetailsResponse: Codable {
    
    let status: String
    let results: PlaceDetail?
}
