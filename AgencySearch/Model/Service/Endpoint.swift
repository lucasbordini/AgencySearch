//
//  Router.swift
//  AgencySearch
//
//  Created by Lucas Bordini Ribeiro de Araujo on 01/04/20.
//  Copyright © 2020 Lucas Bordini Ribeiro de Araujo. All rights reserved.
//

import Foundation

enum Endpoint {

    case findNearby
    case details
    case image
    
    var scheme: String {
        switch self {
        case .findNearby, .details, .image:
            return "https"
        }

    }
    
    var host: String {
        switch self {
        case .findNearby, .details, .image:
            return "maps.googleapis.com"
        }
    }
    
    var path: String {
        switch self {
        case .findNearby:
            return "/maps/api/place/nearbysearch/json"
        case .details:
            return "/maps/api/place/details/json"
        case .image:
            return "/maps/api/place/photo"
        }
    }
    
    var method: String {
        switch self {
        case .findNearby, .details, .image:
            return "GET"
        }
    }

}
