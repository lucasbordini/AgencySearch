//
//  MapsViewModel.swift
//  AgencySearch
//
//  Created by Lucas Bordini Ribeiro de Araujo on 03/04/20.
//  Copyright © 2020 Lucas Bordini Ribeiro de Araujo. All rights reserved.
//

import UIKit
import CoreLocation.CLLocation

class PlacesViewModel {
    
    var places: DynamicType<[NearbyPlaces]> = DynamicType<[NearbyPlaces]>()
    var placeDetail: DynamicType<PlaceDetail> = DynamicType<PlaceDetail>()
    var placeImage: DynamicType<UIImage> = DynamicType<UIImage>()
    var serverError: DynamicType<String> = DynamicType<String>()
    var error: DynamicType<Error> = DynamicType<Error>()
    
    let repository: PlacesRepository
    
    init(repository: PlacesRepository) {
        self.repository = repository
    }
    
    func fetchPlaces(location: CLLocationCoordinate2D) {
        repository.getNearby(coord: location) { (result: Result<Places, Error>) in
            switch result {
            case .success(let places):
                if !(places.errorMessage?.isEmpty ?? true) {
                    self.serverError.value = places.errorMessage
                } else {
                    self.places.value = places.candidates
                }
            case .failure(let error):
                self.error.value = error
            }
        }
    }
    
    func fetchPlaceDetail(for id: String) {
        repository.getDetails(placeId: id, completion: { (result: Result<PlaceDetailsResponse, Error>) in
            switch result {
            case .success(let details):
                self.placeDetail.value = details.results
            case .failure(let err):
                self.error.value = err
            }
        })
    }
    
    func fetchImage(reference: String, maxWidth: CGFloat) {
        repository.getImage(reference: reference, maxWidth: "\(maxWidth)") { image in
            self.placeImage.value = image
        }
    }
    
}
