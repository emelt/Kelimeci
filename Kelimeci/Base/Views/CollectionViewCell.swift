//
//  CollectionViewCell.swift
//  Kelimeci
//
//  Created by Emel Topaloglu on 8/24/17.
//  Copyright © 2018 Emel Topaloglu. All rights reserved.
//

import UIKit
import Kelimeci

class CollectionViewCell: UICollectionViewCell {
    static var reuseIdentifier: String {
        return self.className
    }
}
