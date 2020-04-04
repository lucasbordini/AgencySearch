//
//  Alert.swift
//  AgencySearch
//
//  Created by Lucas Bordini Ribeiro de Araujo on 03/04/20.
//  Copyright © 2020 Lucas Bordini Ribeiro de Araujo. All rights reserved.
//

import UIKit

func Alert(title: String = "", message: String = "") -> UIAlertController {
    let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
    let alertAction = UIAlertAction(title: "Ok", style: .default, handler: nil)
    alertController.addAction(alertAction)
    return alertController
}
