//
//  OpeningHours.swift
//  AgencySearch
//
//  Created by Lucas Bordini Ribeiro de Araujo on 03/04/20.
//  Copyright © 2020 Lucas Bordini Ribeiro de Araujo. All rights reserved.
//

import Foundation

struct OpeningHours {
    let openNow: Bool
    let periods: [Periods]
    let weekdayText: String
}

extension OpeningHours: Codable {
    
    enum CodingKeys: String, CodingKey {
        case openNow = "open_now"
        case weekdayText = "weekday_text"
        case periods
    }
}
