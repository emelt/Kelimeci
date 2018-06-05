//
//  UIView+Borders.swift
//  Kelimeci
//
//  Created by Emel Topaloglu on 1/27/17.
//  Copyright © 2018 Emel Topaloglu. All rights reserved.
//

import UIKit

@objc
enum UIAxis: Int {
    case horizontal
    case vertical
}

extension UIView {
    struct K {
        static fileprivate let tag = 721
        static let defaultSeperatorWidth: CGFloat = 0.5
    }

    func addRoundedDashedLayer(with color: UIColor, pattern: [NSNumber]) {
        let border = CAShapeLayer()
        border.strokeColor = color.cgColor
        border.fillColor = nil
        border.lineDashPattern = pattern
        self.layer.addSublayer(border)
        border.frame = self.bounds
        border.path = UIBezierPath(roundedRect: self.bounds, cornerRadius: self.frame.size.width / 2).cgPath
    }
    
    func addBorders(_ color: UIColor, thickness: CGFloat = K.defaultSeperatorWidth, insets: UIEdgeInsets = UIEdgeInsets.zero) {
        clearBorders()
        addBordersTo([UIRectEdge.top, UIRectEdge.left, UIRectEdge.bottom, UIRectEdge.right], color: color, thickness: thickness, insets: insets)
    }
    
    func addBordersTo(_ edges: [UIRectEdge], color: UIColor, thickness: CGFloat = K.defaultSeperatorWidth, insets: UIEdgeInsets = UIEdgeInsets.zero) {
        clearBorders()
        edges.forEach { addBorderTo($0, color: color, thickness: thickness, insets: insets) }
    }
    
    func addBorderTo(_ edge: UIRectEdge, color: UIColor, thickness: CGFloat = K.defaultSeperatorWidth, insets: UIEdgeInsets = UIEdgeInsets.zero) {
        switch edge {
        case UIRectEdge.top:
            let border = createBorder(color, thickness: thickness, axis: .horizontal)
            addSubview(border)
            border.topAnchor.constraint(equalTo: topAnchor, constant: insets.top).isActive = true
            border.leadingAnchor.constraint(equalTo: leadingAnchor, constant: insets.left).isActive = true
            border.trailingAnchor.constraint(equalTo: trailingAnchor, constant: insets.right).isActive = true
        case UIRectEdge.bottom:
            let border = createBorder(color, thickness: thickness, axis: .horizontal)
            addSubview(border)
            border.leadingAnchor.constraint(equalTo: leadingAnchor, constant: insets.left).isActive = true
            border.bottomAnchor.constraint(equalTo: bottomAnchor, constant: insets.bottom).isActive = true
            border.trailingAnchor.constraint(equalTo: trailingAnchor, constant: insets.right).isActive = true
        case UIRectEdge.left:
            let border = createBorder(color, thickness: thickness, axis: .vertical)
            addSubview(border)
            border.topAnchor.constraint(equalTo: topAnchor, constant: insets.top).isActive = true
            border.leadingAnchor.constraint(equalTo: leadingAnchor, constant: insets.left).isActive = true
            border.bottomAnchor.constraint(equalTo: bottomAnchor, constant: insets.bottom).isActive = true
        case UIRectEdge.right:
            let border = createBorder(color, thickness: thickness, axis: .vertical)
            addSubview(border)
            border.topAnchor.constraint(equalTo: topAnchor, constant: insets.top).isActive = true
            border.bottomAnchor.constraint(equalTo: bottomAnchor, constant: insets.bottom).isActive = true
            border.trailingAnchor.constraint(equalTo: trailingAnchor, constant: insets.right).isActive = true
        default:
            break
        }
    }
    
    func clearBorders() {
        subviews.filter({ (subview: UIView) -> Bool in
            return subview.tag == K.tag
        }).forEach({ (subview: UIView) in
            subview.removeFromSuperview()
        })
    }
    
    fileprivate func createBorder(_ color: UIColor, thickness: CGFloat, axis: UIAxis) -> UIView {
        let border = UIView()
        border.backgroundColor = color
        border.translatesAutoresizingMaskIntoConstraints = false
        border.tag = K.tag
        switch axis {
        case .horizontal:
            border.heightAnchor.constraint(equalToConstant: thickness).isActive = true
        case .vertical:
            border.widthAnchor.constraint(equalToConstant: thickness).isActive = true
        }
        return border
    }
    
}
