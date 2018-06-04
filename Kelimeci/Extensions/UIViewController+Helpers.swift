//
//  UIViewController+Helpers.swift
//  Kelimeci
//
//  Created by Sinem Alak on 11/22/16.
//  Copyright © 2016 Swenson He. All rights reserved.
//

public extension UIViewController {
    class func instanceFromStoryboard(name storyboardName: String, viewControllerId: String? = nil) -> Self? {
        let vcId = viewControllerId != nil ? viewControllerId! : String(describing: self)
        return instanceFromStoryboardHelper(name: storyboardName, viewControllerId: vcId)
    }
    
    class func instanceFromStoryboardWithControllerId (name storyboardName: String) -> Self? {
        return instanceFromStoryboardHelper(name: storyboardName, viewControllerId: String(describing: self))
    }
    
    class func instanceFromNib() -> Self? {
        return instanceFromNibHelper()
    }
}

internal extension UIViewController {
    
    class func instanceFromStoryboardHelper<T>(name storyboardName: String, viewControllerId: String) -> T? {
        let storyboard = UIStoryboard(name: storyboardName, bundle: nil)
        guard let viewController = storyboard.instantiateViewController(withIdentifier: viewControllerId) as? T else {
            return nil
        }
        
        return viewController
    }
    
    class func instanceFromNibHelper<T: UIViewController>() -> T? {
        let nibName = String(describing: T.self)
        return T(nibName: nibName, bundle: nil)
    }
}
