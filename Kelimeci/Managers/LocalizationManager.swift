//
//  LocalizationManager.swift
//  Kelimeci
//
//  Created by Emel Topaloglu on 8/24/17.
//  Copyright © 2017 Emel Topaloglu. All rights reserved.
//

import Foundation

func Localized(_ string: String) -> String {
    return NSLocalizedString(string, comment: "")
}

func LocalizedUppercase(_ string: String) -> String {
    return NSLocalizedString(string, comment: "").uppercased()
}
