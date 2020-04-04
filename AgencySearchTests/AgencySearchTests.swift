//
//  AgencySearchTests.swift
//  AgencySearchTests
//
//  Created by Lucas Bordini Ribeiro de Araujo on 01/04/20.
//  Copyright © 2020 Lucas Bordini Ribeiro de Araujo. All rights reserved.
//

import XCTest
import CoreLocation
@testable import AgencySearch

class AgencySearchTests: XCTestCase {
    
    override func setUp() {
    }
    
    override func tearDown() {
    }
    
    func testFetchPlaces() {
        let expectation:XCTestExpectation = self.expectation(description: "Fetch Places")
        let repository = DefaultPlacesRepository()
        repository.getNearby(coord: CLLocationCoordinate2D(latitude: -22.923299, longitude: -47.061924)) { (result: Result<Places, Error>) in
            expectation.fulfill()
            switch result {
            case .success(let places): XCTAssertNotNil(places)
            case .failure(let error): XCTAssertNotNil(error)
            }
        }
        
        self.waitForExpectations(timeout: 30, handler:{ error in
            print ("Fetched data")
        })
    }
    
    func testFetchPlaceDetails() {
        let expectation:XCTestExpectation = self.expectation(description: "Fetch Places")
        let repository = DefaultPlacesRepository()
        repository.getDetails(placeId: "ChIJN1t_tDeuEmsRUsoyG83frY4") { (result: Result<PlaceDetailsResponse, Error>) in
            expectation.fulfill()
            switch result {
            case .success(let placeDetail): XCTAssertNotNil(placeDetail)
            case .failure(let error): XCTAssertNotNil(error)
            }
        }
        self.waitForExpectations(timeout: 30, handler:{ error in
            print ("Fetched data")
        })
    }
    
    func testFetchImage() {
        let expectation:XCTestExpectation = self.expectation(description: "Fetch Places")
        let repository = DefaultPlacesRepository()
        repository.getImage(reference: "CnRtAAAATLZNl354RwP_9UKbQ_5Psy40texXePv4oAlgP4qNEkdIrkyse7rPXYGd9D_Uj1rVsQdWT4oRz4QrYAJNpFX7rzqqMlZw2h2E2y5IKMUZ7ouD_SlcHxYq1yL4KbKUv3qtWgTK0A6QbGh87GB3sscrHRIQiG2RrmU_jF4tENr9wGS_YxoUSSDrYjWmrNfeEHSGSc3FyhNLlBU", maxWidth: "400") { (result: UIImage) in
            expectation.fulfill()
            XCTAssertNotNil(result)
        }
        self.waitForExpectations(timeout: 30, handler:{ error in
            print ("Fetched data")
        })
    }
    
}
