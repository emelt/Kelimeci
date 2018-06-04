//
//  NavigationBar.swift
//  Kelimeci
//
//  Created by Emel Topaloglu on 6/4/18.
//  Copyright © 2018 Emel Topaloglu. All rights reserved.
//

import Foundation

extension UINavigationController {
    func styleClear() {
        navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationBar.shadowImage = UIImage()
        navigationBar.isTranslucent = true
    }
}

extension UINavigationBar {
    class func styleDefaults() {
        let navigationBar = UINavigationBar.appearance()
        let backImage = #imageLiteral(resourceName: "iconBack").withRenderingMode(.alwaysOriginal)
        navigationBar.backIndicatorImage = backImage
        navigationBar.backIndicatorTransitionMaskImage = backImage
    }
}
