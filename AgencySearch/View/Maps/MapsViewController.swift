//
//  ViewController.swift
//  AgencySearch
//
//  Created by Lucas Bordini Ribeiro de Araujo on 01/04/20.
//  Copyright © 2020 Lucas Bordini Ribeiro de Araujo. All rights reserved.
//

import UIKit
import MapKit

class MapsViewController: UIViewController {
    
    //MARK: - Outlets
    @IBOutlet private weak var mapView: MKMapView!
    
    //MARK: - Variables
    let locationManager = CLLocationManager()
    
    let placeDataModel: PlacesViewModel = PlacesViewModel(repository: DefaultPlacesRepository())
    
    override func viewDidLoad() {
        super.viewDidLoad()
        checkLocationAuthorization()
    }
    
    func bind() {
        placeDataModel.places.bind { [weak self] places in
            self?.insertPlaces(places)
        }
        placeDataModel.serverError.bind { [weak self] error in
            self?.present(Alert(message: error), animated: true)
        }
        placeDataModel.error.bind { [weak self] error in
            self?.present(Alert(title: "Erro!", message: error.localizedDescription), animated: true)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let vc = segue.destination as? PlaceDetailViewController, let placeId = sender as? String {
            vc.placeId = placeId
        }
    }
    
}

extension MapsViewController: CLLocationManagerDelegate {
    
    func checkLocationServices() {
        if CLLocationManager.locationServicesEnabled() {
            checkLocationAuthorization()
        } else {
            present(Alert(message: "Por favor verifique se a conexão com o GPS está habilitada"), animated: true)
        }
    }
    
    func checkLocationAuthorization() {
        switch CLLocationManager.authorizationStatus() {
        case .authorizedWhenInUse, .authorizedAlways:
            mapView.showsUserLocation = true
            placeDataModel.fetchPlaces(location: mapView.userLocation.coordinate)
        case .denied:
            present(Alert(message: "Você não nos deu permissão para usar o GPS, por favor, habilite-a"), animated: true)
        case .notDetermined:
            locationManager.requestWhenInUseAuthorization()
        case .restricted:
            present(Alert(message: "Por favor verifique se a conexão com o GPS está habilitada"), animated: true)
        @unknown default:
            present(Alert(message: "Houve algum error ao tentar adquirir sua localização, por favor verifique e tente novamente"), animated: true)
        }
    }
    
    func insertPlaces(_ places: [NearbyPlaces]) {
        for place in places {
            let annotation = PointAnnotation()
            annotation.title = place.name
            annotation.id = place.placeId
            annotation.coordinate = CLLocationCoordinate2D(latitude: place.geometry.location.latitude, longitude: place.geometry.location.longitude)
            mapView.addAnnotation(annotation)
        }
    }
}

extension MapsViewController: MKMapViewDelegate {
    
    func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
        if let point = view.annotation as? PointAnnotation {
            performSegue(withIdentifier: "showDetails", sender: point.id)
        }
    }
}

