//
//  MapsService.swift
//  AgencySearch
//
//  Created by Lucas Bordini Ribeiro de Araujo on 01/04/20.
//  Copyright © 2020 Lucas Bordini Ribeiro de Araujo. All rights reserved.
//

import CoreLocation
import Foundation
import UIKit.UIImage

protocol PlacesRepository {
    func getNearby(coord: CLLocationCoordinate2D, completion: @escaping (Result<Places, Error>) -> Void)
    func getDetails(placeId: String, completion: @escaping (Result<PlaceDetailsResponse, Error>) -> Void)
    func getImage(reference: String, maxWidth: String, completion: @escaping (UIImage) -> Void)
}

class DefaultPlacesRepository: PlacesRepository {
    
    func getNearby(coord: CLLocationCoordinate2D, completion: @escaping (Result<Places, Error>) -> Void) {
        let parameters = [URLQueryItem(name: "location", value: "\(coord.latitude),\(coord.longitude)"),
                          URLQueryItem(name: "radius", value: "20000"),
                          URLQueryItem(name: "keyword", value: "itau"),
                          URLQueryItem(name: "key", value: AppConfiguration.apiKey)]
        ServiceLayer.request(router: Endpoint.findNearby, parameters: parameters) { (result: Result<Places, Error>) in
            completion(result)
        }
    }
    
    func getDetails(placeId: String, completion: @escaping (Result<PlaceDetailsResponse, Error>) -> Void) {
        let parameters = [URLQueryItem(name: "place_id", value: placeId),
                          URLQueryItem(name: "fields", value: "formatted_address,name,photo,formatted_phone_number,opening_hours"),
                          URLQueryItem(name: "key", value: AppConfiguration.apiKey),
                          URLQueryItem(name: "language", value: "pt-BR")]
        ServiceLayer.request(router: Endpoint.details, parameters: parameters) { (result: Result<PlaceDetailsResponse, Error>) in
            completion(result)
        }
    }
    
    func getImage(reference: String, maxWidth: String, completion: @escaping (UIImage) -> Void) {
        let parameters = [URLQueryItem(name: "key", value: AppConfiguration.apiKey),
                          URLQueryItem(name: "photoreference", value: reference),
                          URLQueryItem(name: "maxwidth", value: maxWidth)]
        ImageLoaderService.loadImage(from: Endpoint.image, parameters: parameters) { (result: Result<UIImage?, Error>) in
            switch result {
            case .success(let image):
                if let image = image {
                    completion(image)
                } else {
                    guard let image = UIImage(named: "itau") else { return }
                    completion(image)
                }
            case .failure(_):
                guard let image = UIImage(named: "itau") else { return }
                completion(image)
            }
        }
        
    }
    
}
