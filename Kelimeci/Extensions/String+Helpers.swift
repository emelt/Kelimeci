//
//  String+Helpers.swift
//  Kelimeci
//
//  Created by Emel Topaloglu on 2/9/17.
//  Copyright © 2018 Emel Topaloglu. All rights reserved.
//

import Foundation

public extension String {
    
    var first: String {
        return String(characters.prefix(1))
    }
    var last: String {
        return String(characters.suffix(1))
    }
    var lowercaseFirst: String {
        return first.lowercased() + String(characters.dropFirst())
    }
    
    var digits: String {
        return components(separatedBy: CharacterSet.decimalDigits.inverted)
            .joined()
    }
    
    var underscoreToCamelCase: String {
        let items = self.components(separatedBy: "_")
        var camelCase = ""
        items.enumerated().forEach {
            camelCase += 0 == $0 ? $1 : $1.capitalized
        }
        return camelCase
    }
    
    var camelCaseToUnderscore: String {
        var newString: String = ""
        
        for eachCharacter in self.characters {
            if (eachCharacter >= "A" && eachCharacter <= "Z") == true {
                let str = String(eachCharacter)
                newString.append("_\(str.lowercased())")
            } else {
                newString.append(eachCharacter)
            }
        }
        
        return newString
    }
    
    func bundleClass() -> AnyClass? {
        /// get namespace
        if let namespace = Bundle.main.infoDictionary!["CFBundleExecutable"] as? String {
            let fullClassName = "\(namespace).\(self)"
            /// get 'anyClass' with classname and namespace
            let cls: AnyClass? = NSClassFromString(fullClassName)
            
            // return AnyClass!
            return cls
        }
        return nil
    }
    
    // MARK: Validation
    
    func isValidEmail() -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
        
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailTest.evaluate(with: self)
    }
    
    func isAlphanumeric() -> Bool {
        return !isEmpty && range(of: "[^a-zA-Z0-9]", options: .regularExpression) == nil
    }
    
    func isLowercaseAndNumeric() -> Bool {
        return !isEmpty && range(of: "[^a-z0-9]", options: .regularExpression) == nil
    }
    
}

//TODO: Swift 4 update
//public extension String {
//    func NSRangeFromRange(range: Range<String.Index>) -> NSRange {
//        let utf16view = self.utf16
//        let from = String.UTF16View.Index(range.lowerBound, within: utf16view)
//        let to = String.UTF16View.Index(range.upperBound, within: utf16view)
//        return NSMakeRange(from - utf16view.startIndex, to - from)
//    }
//}

public extension String {
    func toPointer() -> UnsafeMutablePointer<Int8> {
        let buffer = UnsafeMutablePointer<Int8>.allocate(capacity: self.characters.count)
        return UnsafeMutablePointer<Int8>(buffer)
    }
}
