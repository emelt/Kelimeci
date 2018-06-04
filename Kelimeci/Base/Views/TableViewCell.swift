//
//  TableViewCell.swift
//  Kelimeci
//
//  Created by Emel Topaloglu on 7/26/17.
//  Copyright © 2018 Emel Topaloglu. All rights reserved.
//

import UIKit

class TableViewCell: UITableViewCell {
    static var reuseIdentifier: String {
        return self.className
    }
}
