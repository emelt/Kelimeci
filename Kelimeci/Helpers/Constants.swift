//
//  Constants.swift
//  Kelimeci
//
//  Created by Emel Topaloglu on 8/24/17.
//  Copyright © 2017 Emel Topaloglu. All rights reserved.
//

import UIKit

struct K {
    struct AspectRatio {
        //height / width
        static let landscape: CGFloat = 9 / 16
        static let portrait: CGFloat = 4 / 3
        static let featuredMediaCover: CGFloat = 15 / 11
        static let profileImage: CGFloat = 1 / 1
        static let profileCoverImage: CGFloat = 550 / 375
    }
    
    struct VideoSize {
        static let portrait: CGSize = CGSize(width: 750, height: 1000)
        static let landscape: CGSize = CGSize(width: 750, height: 422)
    }
    
    struct Animation {
        static let shoppableVideoSliding: TimeInterval = 3.0
        static let shoppableVideoDisappearing: TimeInterval = 1.0
        static let loginVideoAppearing: TimeInterval = 1.0
        static let exploreFeedVideoTransition: TimeInterval = 0.3
        static let defaultDuration: TimeInterval = 0.3
        static let filterViewAnimation: TimeInterval = 1.0
        static let banner: TimeInterval = 2.0
        static let fast: TimeInterval = 0.1
    }
    
    struct Keychain {
        static let service = "com.emeltopaloglu.kelimeci"
        static let authToken = "authToken"
        static let pushToken = "pushToken"
        static let user = "user"
    }
    
    struct Radius {
        static let defaultButton: CGFloat = 25.0
        static let alertButton: CGFloat = 20.0
        static let alertView: CGFloat = 15.0
        static let tile: CGFloat = 5.0
        static let multiCamPreview: CGFloat = 5.0
    }
    
    struct FileNames {
        static let fileMovExtention: String = "mov"
        static let fileMp3Extention: String = "mp3"
        static let loginLoopVideo: String = "login_loop"
        static let loginInitialVideo: String = "login_initial"
        static let loginMusic: String = "login_music"
    }
    
    struct Media {
        static let imageExtension = "jpeg"
        static let videoExtension = "mov"
    }
    
    struct Border {
        static let defaultBorderWidth: CGFloat = 2.0
        static let mediumBorderWidth: CGFloat = 1.0
        static let thinBorderWidth: CGFloat = 0.5
    }
    
    struct Padding {
        static let medium: CGFloat = 20.0
        static let small: CGFloat = 15.0
        static let large: CGFloat = 25.0
    }
    
    struct NotificationName {
        static let gearTagAdded = Notification.Name("gearTagAdded")
        static let gearTagEdited = Notification.Name("gearTagEdited")
        static let featuredVideoDownloaded = Notification.Name("featuredVideoDownloaded")
        static let remoteNotificationReceived = Notification.Name("remoteNotificationReceived")
        static let remoteNotificationViewed = Notification.Name("remoteNotificationViewed")
        static let uploadProgressChanged = Notification.Name("uploadProgressChanged")
    }
    
    struct CellHeight {
        static let `default`: CGFloat = 44.0
        static let medium: CGFloat = 88.0
        static let shortPickerCell: CGFloat = 48.0
        static let picker: CGFloat = 216.0
    }
    
    static let months = ["01", "02", "03", "04", "05", "06", "07", "08", "09", "10", "11", "12"]
    
    static var years: [String] = {
        let currentYear = Calendar.current.component(.year, from: Date())
        
        var array: [String] = []
        for i in 0...11 {
            array.append(String(currentYear + i))
        }
        return array
    } ()
    
    static var storeSearchRadius: UInt = 40000
}
