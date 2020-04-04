//
//  isMock.swift
//  AgencySearch
//
//  Created by Lucas Bordini Ribeiro de Araujo on 03/04/20.
//  Copyright © 2020 Lucas Bordini Ribeiro de Araujo. All rights reserved.
//

import Foundation

func isMock() -> Bool {
    #if MOCK
    return true
    #else
    return false
    #endif
}
