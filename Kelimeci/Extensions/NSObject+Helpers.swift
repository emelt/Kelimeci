//
//  NSObject+Helpers.swift
//  Kelimeci
//
//  Created by Emel Topaloglu on 1/27/17.
//  Copyright © 2018 Emel Topaloglu. All rights reserved.
//

import Foundation

public extension NSObject {
    static var className: String {
        return NSStringFromClass(self).components(separatedBy: ".").last!
    }
}
