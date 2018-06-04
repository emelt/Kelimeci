//
//  UITableViewCell+Helpers.swift
//  Kelimeci
//
//  Created by Bugra Sirin on 10/19/17.
//  Copyright © 2018 Emel Topaloglu. All rights reserved.
//

import Foundation
import UIKit

public extension UITableViewCell {
    class func defaultReuseIdentifier() -> String {
        let className = String.init(describing: self)
        return className
    }
}
