//
//  UIFont.swift
//  Kelimeci
//
//  Created by Emel Topaloglu on 2/20/17.
//  Copyright © 2018 Emel Topaloglu. All rights reserved.
//

import Foundation

public extension UIFont {
    
    func withTraits(traits: UIFontDescriptorSymbolicTraits...) -> UIFont {
        if let descriptor = self.fontDescriptor
            .withSymbolicTraits(UIFontDescriptorSymbolicTraits(traits)) {
            return UIFont(descriptor: descriptor, size: 0)
        }
        return self
    }
    
    func italic() -> UIFont {
        return withTraits(traits: .traitItalic)
    }
    
    func expanded() -> UIFont {
        return withTraits(traits: .traitExpanded)
    }
}
