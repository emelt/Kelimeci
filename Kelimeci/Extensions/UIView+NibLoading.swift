//
//  UIView+NibLoading.swift
//  Kelimeci
//
//  Created by Emel Topaloglu on 1/27/17.
//  Copyright © 2018 Emel Topaloglu. All rights reserved.
//

import Foundation

public protocol UIViewLoading {}
extension UIView : UIViewLoading {}

public extension UIViewLoading where Self : UIView {
    
    // note that this method returns an instance of type `Self`, rather than UIView
    static func instanceFromNib() -> Self! {
        let nib = UINib(nibName: className, bundle: nil)
        return nib.instantiate(withOwner: self, options: nil).first as! Self
    }
}
