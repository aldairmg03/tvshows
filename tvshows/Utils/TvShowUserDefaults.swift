//
//  TvShowUserDefaults.swift
//  tvshows
//
//  Created by Aldair Martínez on 03/12/22.
//

import Foundation

class TvShowUserDefaults {
    private let defaults = UserDefaults.standard
    
    private let keyRequestToken = "request_token"
    private let keyUsername = "username"
  
    var requestToken: String? {
        set {
            defaults.set(newValue, forKey: keyRequestToken)
        }
        get {
            return defaults.string(forKey: keyRequestToken)
        }
    }
    
    var username: String? {
        set {
            defaults.set(newValue, forKey: keyUsername)
        }
        get {
            return defaults.string(forKey: keyUsername)
        }
    }
    
    class var shared: TvShowUserDefaults {
        struct Static {
            static let instance = TvShowUserDefaults()
        }
        return Static.instance
    }
    
}
