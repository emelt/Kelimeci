//
//  UIView+Autolayout.swift
//  Kelimeci
//
//  Created by Sinem Alak on 11/22/16.
//  Copyright © 2016 Swenson He. All rights reserved.
//

import UIKit

public let layoutPriorityAlmostRequired = UILayoutPriorityRequired - 1.0

public enum Placement: Int {
    case top
    case leading
    case bottom
    case trailing
}

public struct LayoutConstraintProperties {
    var relation: NSLayoutRelation = .equal
    var multiplier: CGFloat = 1.0
    var priority: UILayoutPriority = UILayoutPriorityRequired
    
    mutating func layoutConstraintPropertiesMake(relation: NSLayoutRelation, multiplier: CGFloat, priority: UILayoutPriority) {
        self.relation = relation
        self.multiplier = multiplier
        self.priority = priority
    }
    
    mutating func layoutConstraintPropertiesWithRelation(relation: NSLayoutRelation) {
        return layoutConstraintPropertiesMake(relation: relation, multiplier: 1.0, priority: UILayoutPriorityRequired)
    }
    
    mutating func layoutConstraintPropertiesWithMultiplier(multiplier: CGFloat) {
        return layoutConstraintPropertiesMake(relation: .equal, multiplier: multiplier, priority: UILayoutPriorityRequired)
    }
    
    mutating func layoutConstraintPropertiesWithPriority(priority: UILayoutPriority) {
        return layoutConstraintPropertiesMake(relation: .equal, multiplier: 1.0, priority: priority)
    }
}

public extension UIView {
    @discardableResult
    func constraintAllDistancesToSuperview(value: CGFloat) -> [NSLayoutConstraint] {
        let bottom = constraintDistanceToSuperview(value: 0.0, at: .bottom)
        let top = constraintDistanceToSuperview(value: 0.0, at: .top)
        let leading = constraintDistanceToSuperview(value: 0.0, at: .leading)
        let trailing = constraintDistanceToSuperview(value: 0.0, at: .trailing)
        return [bottom, top, leading, trailing]
    }
    
    @discardableResult
    func constraintDistanceToSuperview(value: CGFloat, at: Placement) -> NSLayoutConstraint {
        return constraintDistanceToSuperview(value: value, at: at, properties: LayoutConstraintProperties())
    }
    
    @discardableResult
    func constraintAlignment(alignment: NSLayoutAttribute, toView: UIView, distance: CGFloat) -> NSLayoutConstraint! {
        let constraint = NSLayoutConstraint(item: self, attribute: alignment, relatedBy: .equal, toItem: toView, attribute: alignment, multiplier: 1, constant: distance)
        superview?.addConstraint(constraint)
        return constraint
    }
    
    @discardableResult
    func constraintAlignment(alignment: NSLayoutAttribute, toView: UIView, viewAlignment: NSLayoutAttribute, distance: CGFloat) -> NSLayoutConstraint! {
        let constraint = NSLayoutConstraint(item: self, attribute: alignment, relatedBy: .equal, toItem: toView, attribute: viewAlignment, multiplier: 1, constant: distance)
        superview?.addConstraint(constraint)
        return constraint
    }
    
    @discardableResult
    func heightConstraint(value: CGFloat) -> NSLayoutConstraint {
        let constraint = NSLayoutConstraint(item: self,
                                            attribute: .height,
                                            relatedBy: .equal,
                                            toItem: nil,
                                            attribute: .notAnAttribute,
                                            multiplier: 1,
                                            constant: value)
        
        superview?.addConstraint(constraint)
        return constraint
    }
    
    @discardableResult
    func widthConstraint(value: CGFloat) -> NSLayoutConstraint {
        let constraint = NSLayoutConstraint(item: self,
                                            attribute: .width,
                                            relatedBy: .equal,
                                            toItem: nil,
                                            attribute: .notAnAttribute,
                                            multiplier: 1,
                                            constant: value)
        
        superview?.addConstraint(constraint)
        return constraint
    }
    
    @discardableResult
    func horizontalAlignment(value: CGFloat) -> NSLayoutConstraint {
        let constraint = NSLayoutConstraint(item: self,
                                            attribute: .centerX,
                                            relatedBy: .equal,
                                            toItem: self.superview,
                                            attribute: .centerX,
                                            multiplier: 1,
                                            constant: value)
        
        superview?.addConstraint(constraint)
        return constraint
    }
    
    @discardableResult
    func verticalAlignment(value: CGFloat) -> NSLayoutConstraint {
        let constraint = NSLayoutConstraint(item: self,
                                            attribute: .centerY,
                                            relatedBy: .equal,
                                            toItem: self.superview,
                                            attribute: .centerY,
                                            multiplier: 1,
                                            constant: value)
        
        superview?.addConstraint(constraint)
        return constraint
    }
    
    @discardableResult
    func constraintDistanceToSuperview(value: CGFloat, at: Placement, properties: LayoutConstraintProperties) -> NSLayoutConstraint {
        
        let attribute: NSLayoutAttribute
        
        switch at {
        case .top:
            attribute = .top
            break
        case .bottom:
            attribute = .bottom
            break
        case .leading:
            attribute = .leading
            break
        case .trailing:
            attribute = .trailing
            break
        }
        
        let constraint = NSLayoutConstraint(item: self,
                                                 attribute: attribute,
                                                 relatedBy: properties.relation,
                                                 toItem: superview,
                                                 attribute: attribute,
                                                 multiplier: properties.multiplier,
                                                 constant: value)
        
        constraint.priority = properties.priority
        superview?.addConstraint(constraint)
        
        return constraint
    }
}
