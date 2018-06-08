//
//  Styleguide.swift
//  Kelimeci
//
//  Created by Emel Topaloglu on 8/24/17.
//  Copyright © 2017 Emel Topaloglu. All rights reserved.
//

import UIKit

extension UIColor {
    class var kWhite: UIColor {
        return UIColor(white: 255.0 / 255.0, alpha: 1.0)
    }
    
    class var kSoftWhite: UIColor {
        return UIColor(white: 242.0 / 255.0, alpha: 1.0)
    }
    
    class var kBlack: UIColor {
        return UIColor(red: 0.0 / 255.0, green: 0.0 / 255.0, blue: 0.0 / 255.0, alpha: 1.0)
    }
    
    class var kPink: UIColor {
        return UIColor(red: 164.0 / 255.0, green: 113.0 / 255.0, blue: 114.0 / 255.0, alpha: 1.0)
    }
    
    class var kGray: UIColor {
        return UIColor(red: 52.0 / 255.0, green: 59.0 / 255.0, blue: 71.0 / 255.0, alpha: 1.0)
    }
    
    class var kDarkGray: UIColor {
        return UIColor(red: 32.0 / 255.0, green: 36.0 / 255.0, blue: 52.0 / 255.0, alpha: 1.0)
    }
}

extension UIFont {
    // MARK: Fonts
    class func mfAvenirRoman(size: Float) -> UIFont {
        return UIFont(name: "Avenir-Roman", size: CGFloat(size))!
    }
    
    class func mfAvenirLight(size: Float) -> UIFont {
        return UIFont(name: "Avenir-Book", size: CGFloat(size))!
    }
    
    class func mfAvenirHeavy(size: Float) -> UIFont {
        return UIFont(name: "Avenir-Heavy", size: CGFloat(size))!
    }
    
    class func mfAvenirBlack(size: Float) -> UIFont {
        return UIFont(name: "Avenir-Black", size: CGFloat(size))!
    }
    
    class func mfAvenirBook(size: Float) -> UIFont {
        return UIFont(name: "Avenir-Book", size: CGFloat(size))!
    }
    
    class func mfAvenirMedium(size: Float) -> UIFont {
        return UIFont(name: "Avenir-Medium", size: CGFloat(size))!
    }
}

extension TextStyle {
    static let book12White = TextStyle(font: UIFont.mfAvenirBook(size: 12.0), color: UIColor.kWhite)
    static let book13White = TextStyle(font: UIFont.mfAvenirBook(size: 13.0), color: UIColor.kWhite)
    static let hintTile = TextStyle(font: UIFont.mfAvenirMedium(size: 12.0), color: UIColor.kPink)
    static let characterTile = TextStyle(font: UIFont.mfAvenirMedium(size: 22.0), color: UIColor.kPink)
    static let matchingGuess = TextStyle(font: UIFont.mfAvenirRoman(size: 12.0), color: UIColor.kPink)
    static let missingGuess = TextStyle(font: UIFont.mfAvenirRoman(size: 12.0), color: UIColor.kDarkGray)
    static let guessedWord = TextStyle(font: UIFont.mfAvenirMedium(size: 40.0), color: UIColor.kPink)
    static let gameTypeLabel = TextStyle(font: UIFont.mfAvenirHeavy(size: 23.0), color: UIColor.kWhite)
    static let gameTypeDetailLabel = TextStyle(font: UIFont.mfAvenirRoman(size: 14.0), color: UIColor.kWhite)
}

extension ShadowStyle {
    static let imageShadow = ShadowStyle(color: .kBlack, radius: 10.0, offset: CGSize(width: 1.0, height: 1.0), opacity: 1.0)
    static let labelShadow = ShadowStyle(color: .kBlack, radius: 1.0, offset: CGSize(width: 0.0, height: 1.0), opacity: 0.5)
}

extension LayerStyle {
    static let tile = LayerStyle (
        masksToBounds: true,
        cornerRadius: K.Radius.tile,
        borderStyle: pinkBorder
    )
    
    static let greyBorder = BorderStyle(color: .kBlack, width: K.Border.mediumBorderWidth)
    static let pinkBorder = BorderStyle(color: .kPink, width: 5.0)
    static let yellowBorder = BorderStyle(color: .kBlack, width: K.Border.defaultBorderWidth)
    static let yellowBorderMedium = BorderStyle(color: .kBlack, width: K.Border.mediumBorderWidth)
    static let gameTypeButtonBorder = BorderStyle(color: .kGray, width: 25.0)
}
