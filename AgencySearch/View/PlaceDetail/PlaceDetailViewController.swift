//
//  PlaceDetail.swift
//  AgencySearch
//
//  Created by Lucas Bordini Ribeiro de Araujo on 03/04/20.
//  Copyright © 2020 Lucas Bordini Ribeiro de Araujo. All rights reserved.
//

import UIKit

class PlaceDetailViewController: UIViewController {
    
    @IBOutlet weak private var agencyUIImageView: UIImageView!
    @IBOutlet weak private var addressUILabel: UILabel!
    @IBOutlet weak private var phoneUILabel: UILabel!
    @IBOutlet weak private var openHourUILabel: UILabel!
    
    var placeId: String?
    
    let placeDataModel: PlacesViewModel = PlacesViewModel(repository: DefaultPlacesRepository())
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let id = placeId {
            placeDataModel.fetchPlaceDetail(for: id)
        }
    }
    
    func bind() {
        placeDataModel.placeDetail.bind { [weak self] place in
            if let photo = place.photos.first?.photoReference {
                self?.placeDataModel.fetchImage(reference: photo, maxWidth: self?.view.frame.width ?? 400)
            }
            self?.setupUI(with: place)
        }
        placeDataModel.error.bind { [weak self] error in
            self?.present(Alert(title: "Erro!", message: error.localizedDescription), animated: true)
        }
        placeDataModel.placeImage.bind { [weak self] image in
            self?.agencyUIImageView.image = image
        }
    }
    
    func setupUI(with place: PlaceDetail) {
        navigationController?.navigationItem.title = place.name
        addressUILabel.text = place.formattedAddress
        phoneUILabel.text = place.formattedPhoneNumber
        openHourUILabel.text = place.openingHours.weekdayText
    }
    
}
