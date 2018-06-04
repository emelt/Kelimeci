//
//  Array+Helpers.swift
//  Kelimeci
//
//  Created by Emel Topaloglu on 5/1/17.
//  Copyright © 2018 Emel Topaloglu. All rights reserved.
//

import Foundation

public extension Array where Element: Equatable {
    
    // Remove first collection element that is equal to the given `object`:
    mutating func remove(_ object: Element) {
        if let index = index(of: object) {
            remove(at: index)
        }
    }
}
