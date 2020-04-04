//
//  MapResources.swift
//  AgencySearch
//
//  Created by Lucas Bordini Ribeiro de Araujo on 03/04/20.
//  Copyright © 2020 Lucas Bordini Ribeiro de Araujo. All rights reserved.
//

import Foundation

extension Endpoint {
    
    static func nearby(lat: Double, lng: Double) -> Endpoint<Places> {
        let url = Constants.baseURL.appendingPathComponent("/")
        let parameters = [URLQueryItem(name: "location", value: "\(lat),\(lng)"),
                          URLQueryItem(name: "radius", value: "20000"),
                          URLQueryItem(name: "keyword", value: "itau"),
                          URLQueryItem(name: "key", value: Constants.apiKey)]
        return Endpoint<Places>(url: url, parameters: parameters)
    }
    
    static func details(placeId: String) -> Endpoint<PlaceDetailsResponse> {
        let url = Constants.baseURL.appendingPathComponent("/")
        let parameters = [URLQueryItem(name: "place_id", value: placeId),
                          URLQueryItem(name: "fields", value: "formatted_address,name,photo,formatted_phone_number,opening_hours"),
                          URLQueryItem(name: "key", value: Constants.apiKey)]
        return Endpoint<PlaceDetailsResponse>(url: url, parameters: parameters)
    }
    
}
