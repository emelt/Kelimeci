//
//  UIImage+Helpers.swift
//  Kelimeci
//
//  Created by Emel Topaloglu on 1/27/17.
//  Copyright © 2018 Emel Topaloglu. All rights reserved.
//

import Foundation

public extension UIImage {
    public class func image(color: UIColor) -> UIImage {
        let rect = CGRect(x: 0, y: 0, width: 1, height: 1)
        UIGraphicsBeginImageContext(rect.size)
        let context = UIGraphicsGetCurrentContext()
        
        context!.setFillColor(color.cgColor)
        context!.fill(rect)
        
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return image!
    }
    
    public convenience init(view: UIView) {
        UIGraphicsBeginImageContextWithOptions(view.bounds.size, true, 0)
        view.drawHierarchy(in: view.bounds, afterScreenUpdates: true)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        self.init(cgImage: (image?.cgImage!)!)
    }
    
    public func scale(to size: CGSize) -> UIImage? {
        UIGraphicsBeginImageContext(size)
        draw(in: CGRect(x: 0.0, y: 0.0, width: size.width, height: size.height))
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return newImage
    }
    
    public func cropped(to frame: CGRect) -> UIImage? {
        if let image = self.cgImage, let imageRef = image.cropping(to: frame) {
            let croppedImage = UIImage(cgImage: imageRef)
            return croppedImage
        }
        return nil
    }
}

