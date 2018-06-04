//
//  UICollectionView+Helpers.swift
//  Kelimeci
//
//  Created by Emel Topaloglu on 4/6/17.
//  Copyright © 2018 Emel Topaloglu. All rights reserved.
//

import Foundation

public extension UICollectionView {
    
    func registerClassWithDefaultReuseIdentifier(_ reuseIdentifier: String) {
        if let _ = Bundle.main.path(forResource: reuseIdentifier, ofType: "nib") {
            let nib = UINib(nibName: reuseIdentifier, bundle: nil)
            register(nib, forCellWithReuseIdentifier: reuseIdentifier)
        }
        else {
            register(NSClassFromString(reuseIdentifier), forCellWithReuseIdentifier: reuseIdentifier)
        }
    }
}
