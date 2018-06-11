//
//  UIColor.swift
//  Kelimeci
//
//  Created by Emel Topaloglu on 6/10/18.
//  Copyright © 2018 Emel Topaloglu. All rights reserved.
//

import Foundation

extension UIColor {
    class func blend(colors: [UIColor]) -> UIColor {
        let componentsSum = colors.reduce((red: CGFloat(0), green: CGFloat(0), blue: CGFloat(0))) { (temp, color) in
            guard let components = color.cgColor.components else { return temp }
            return (temp.0 + components[0], temp.1 + components[1], temp.2 + components[2])
        }
        let components = (red: componentsSum.red / CGFloat(colors.count) ,
                          green: componentsSum.green / CGFloat(colors.count),
                          blue: componentsSum.blue / CGFloat(colors.count))
        return UIColor(red: components.red, green: components.green, blue: components.blue, alpha: 1)
    }
}
