//
//  MapsUseCase.swift
//  AgencySearch
//
//  Created by Lucas Bordini Ribeiro de Araujo on 03/04/20.
//  Copyright © 2020 Lucas Bordini Ribeiro de Araujo. All rights reserved.
//

import CoreLocation
import Foundation
import Combine


protocol PlacesUseCase {
    func execute 
}


final class PlacesUseCases {
    
    private let networkService: NetworkServiceType
    private let imageLoaderService: ImageLoaderServiceType
    
    init(networkService: NetworkServiceType, imageLoaderService: ImageLoaderServiceType) {
        self.networkService = networkService
        self.imageLoaderService = imageLoaderService
    }
    
    
}

extension PlacesUseCase: PlacesRepository {
    
    func searchNearby(in location: CLLocationCoordinate2D) -> AnyPublisher<Result<Places, Error>, Never> {
        return networkService
            .load(Endpoint<Places>.nearby(lat: location.latitude, lng: location.longitude))
            .map({ (result: Result<Places, NetworkError>) -> Result<Places, Error> in
                switch result {
                case .success(let places): return .success(places)
                case .failure(let error): return .failure(error)
                }
            })
            .subscribe(on: Scheduler.backgroundWorkScheduler)
            .receive(on: Scheduler.mainScheduler)
            .eraseToAnyPublisher()
    }
    
    func placeDetails(with placeId: String) -> AnyPublisher<Result<PlaceDetail, Error>, Never> {
        return networkService
            .load(Endpoint<PlaceDetailsResponse>.details(placeId: placeId))
            .map({ (result: Result<PlaceDetailsResponse, NetworkError>) -> Result<PlaceDetail, Error> in
                switch result {
                case .success(let placeDetail): return .success(placeDetail.results)
                case .failure(let error): return .failure(error)
                }
            })
            .subscribe(on: Scheduler.backgroundWorkScheduler)
            .receive(on: Scheduler.mainScheduler)
            .eraseToAnyPublisher()
    }
    
}
