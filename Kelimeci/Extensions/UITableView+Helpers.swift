//
//  UITableView+Helpers.swift
//  Kelimeci
//
//  Created by Emel Topaloglu on 1/27/17.
//  Copyright © 2018 Emel Topaloglu. All rights reserved.
//

import Foundation

public extension UITableView {
    
    func registerClassWithDefaultReuseIdentifier(_ reuseIdentifier: String) {
        if let _ = Bundle.main.path(forResource: reuseIdentifier, ofType: "nib") {
            let nib = UINib(nibName: reuseIdentifier, bundle: nil)
            register(nib, forCellReuseIdentifier: reuseIdentifier)
        }
        else {
            register(NSClassFromString(reuseIdentifier), forCellReuseIdentifier: reuseIdentifier)
        }
    }
    
    func registerHeaderFooterWithDefaultReuseIdentifier(_ reuseIdentifier: String) {
        if let _ = Bundle.main.path(forResource: reuseIdentifier, ofType: "nib") {
            let nib = UINib(nibName: reuseIdentifier, bundle: nil)
            register(nib, forHeaderFooterViewReuseIdentifier: reuseIdentifier)
        }
        else {
            register(NSClassFromString(reuseIdentifier), forHeaderFooterViewReuseIdentifier: reuseIdentifier)
        }
    }
}
