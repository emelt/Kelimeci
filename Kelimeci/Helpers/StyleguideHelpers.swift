//
//  StyleguideHelpers.swift
//  Kelimeci
//
//  Created by Emel Topaloglu on 8/24/17.
//  Copyright © 2017 Emel Topaloglu. All rights reserved.
//

import UIKit

// MARK: Structs
struct TextStyle {
    let font: UIFont
    let color: UIColor
}

struct ButtonStyle {
    let defaultColor: UIColor?
    let highlightColor: UIColor?
    let disabledColor: UIColor?
    let selectedColor: UIColor?
    let layerStyle: LayerStyle?
    let textStyle: TextStyle?
    let selectedTextColor: UIColor?
    let highlightedTextColor: UIColor?
    let disabledTextColor: UIColor?
    let tintColor: UIColor?
}

struct LayerStyle {
    struct BorderStyle {
        let color: UIColor
        let width: CGFloat
    }
    
    let masksToBounds: Bool?
    let cornerRadius: CGFloat?
    let borderStyle: BorderStyle?
}

struct ShadowStyle {
    let color: UIColor
    let radius: CGFloat
    let offset: CGSize
    let opacity: Float
}

struct ViewStyle {
    let backgroundColor: UIColor?
    let tintColor: UIColor?
    let layerStyle: LayerStyle?
}

struct ViewControllerStyle {
    let backgroundColor: UIColor?
    let navigationBarStyle: NavigationBarStyle?
}

struct NavigationBarStyle {
    let backgroundColor: UIColor?
    let backgroundImage: UIImage?
    let titleColor: UIColor?
    let titleFont: UIFont?
    let buttonTintColor: UIColor?
    let statusBarStyle: UIStatusBarStyle
    let isTranslucent: Bool
}

struct TableViewStyle {
    let backgroundColor: UIColor?
    let separatorColor: UIColor?
    let separatorInset: UIEdgeInsets?
}

protocol StyleProtocol { }

extension UIViewController: StyleProtocol {
    func style(_ style: ViewControllerStyle) {
        if let backgroundColor = style.backgroundColor {
            view.backgroundColor = backgroundColor
        }
        
        if let navigationBarStyle = style.navigationBarStyle {
            navigationController?.navigationBar.style(navigationBarStyle)
        }
    }
}

extension UIView: StyleProtocol {}

// MARK: Helper extensions
extension StyleProtocol where Self : UIView {
    
    func style(_ style: ViewStyle) {
        if let backgroundColor = style.backgroundColor {
            self.backgroundColor = backgroundColor
        }
        
        if let tintColor = style.tintColor {
            self.tintColor = tintColor
        }
        if let layerStyle = style.layerStyle {
            self.style(layerStyle)
        }
    }
    
    func style(_ style: LayerStyle) {
        if let cornerRadius = style.cornerRadius {
            layer.cornerRadius = cornerRadius
        }
        if let masksToBounds = style.masksToBounds {
            layer.masksToBounds = masksToBounds
        }
        if let borderStyle = style.borderStyle {
            layer.borderColor = borderStyle.color.cgColor
            layer.borderWidth = borderStyle.width
        } else {
            layer.borderColor = nil
            layer.borderWidth = 0
        }
    }
    
    func style(_ style: ShadowStyle) {
        layer.masksToBounds = false
        layer.shadowColor = style.color.cgColor
        layer.shadowOffset = style.offset
        layer.shadowRadius = style.radius
        layer.shadowOpacity = style.opacity
    }
}

extension StyleProtocol where Self : UIButton {
    func style(_ style: ButtonStyle) {
        
        if let layerStyle = style.layerStyle {
            self.style(layerStyle)
        }
        
        if let defaultColor = style.defaultColor {
            setBackgroundImage(UIImage.image(color: defaultColor), for: .normal)
            setBackgroundImage(UIImage.image(color: defaultColor), for: .disabled)
            setBackgroundImage(UIImage.image(color: defaultColor), for: .selected)
            setBackgroundImage(UIImage.image(color: defaultColor), for: .highlighted)
        }
        
        if let highlightedColor = style.highlightColor {
            setBackgroundImage(UIImage.image(color: highlightedColor), for: .highlighted)
        }
        
        if let disabledColor = style.disabledColor {
            setBackgroundImage(UIImage.image(color: disabledColor), for: .disabled)
        }
        
        if let selectedColor = style.selectedColor {
            setBackgroundImage(UIImage.image(color: selectedColor), for: .selected)
        }
        
        if let textStyle = style.textStyle {
            self.style(textStyle)
        }
        
        if let highlightedColor = style.highlightedTextColor {
            setTitleColor(highlightedColor, for: .highlighted)
        }
        
        if let selectedColor = style.selectedTextColor {
            setTitleColor(selectedColor, for: .selected)
        }
        
        if let disabledColor = style.disabledTextColor {
            setTitleColor(disabledColor, for: .disabled)
        }
        
        if let tintColor = style.tintColor {
            self.tintColor = tintColor
        }
    }
    
    func style(_ style: TextStyle) {
        titleLabel?.font = style.font
        setTitleColor(style.color, for: .normal)
    }
}

extension StyleProtocol where Self: UILabel {
    func style(_ style: TextStyle) {
        font = style.font
        textColor = style.color
    }
}

extension StyleProtocol where Self: UITextField {
    func style(_ style: TextStyle) {
        font = style.font
        textColor = style.color
    }
}

extension StyleProtocol where Self: UITextView {
    func style(_ style: TextStyle) {
        font = style.font
        textColor = style.color
    }
}

extension StyleProtocol where Self: UINavigationBar {
    func style(_ style: NavigationBarStyle) {
        
        isTranslucent = style.isTranslucent
        shadowImage = UIImage()
        setBackgroundImage(UIImage(), for: .default)
        
        let navigationBar = UINavigationBar.appearance()
 
        if let titleColor = style.titleColor {
            navigationBar.titleTextAttributes?[NSAttributedStringKey.foregroundColor] = titleColor
        }
        
        if let titleFont = style.titleFont {
            navigationBar.titleTextAttributes?[NSAttributedStringKey.font] = titleFont
        }
        
        if let backgroundColor = style.backgroundColor {
            barTintColor = backgroundColor
        }
        
        if let backgroundImage = style.backgroundImage {
            setBackgroundImage(backgroundImage, for: .default)
        }
        
        if let buttonColor = style.buttonTintColor {
            tintColor = buttonColor
        }
        
        if style.statusBarStyle == .default {
            self.barStyle = .black
        } else {
            self.barStyle = .default
        }
    }
}

extension StyleProtocol where Self: UITableView {
    func style(_ style: TableViewStyle) {
        if let backgroundColor = style.backgroundColor {
            self.backgroundColor = backgroundColor
        }
        
        if let separatorInset = style.separatorInset {
            self.separatorInset = separatorInset
        }
        
        if let separatorColor = style.separatorColor {
            self.separatorColor = separatorColor
        }
    }
}
