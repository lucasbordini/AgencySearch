//
//  DynamicType.swift
//  AgencySearch
//
//  Created by Lucas Bordini Ribeiro de Araujo on 03/04/20.
//  Copyright © 2020 Lucas Bordini Ribeiro de Araujo. All rights reserved.
//

import Foundation

public struct DynamicType<T> {
    
    typealias ModelEventListener = (T) -> Void
    typealias Listeners = [ModelEventListener]
    
    private var listeners:Listeners = []
     
    var value: T? {
        didSet {
            for (_, observer) in listeners.enumerated() {
                if let value = value {
                    observer(value)
                }
            }
            
        }
    }
    
    
    mutating func bind(_ listener: @escaping ModelEventListener) {
        listeners.append(listener)
        if let value = value {
            listener(value)
        }
    }
    
}
