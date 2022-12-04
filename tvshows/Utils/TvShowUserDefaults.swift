//
//  TvShowUserDefaults.swift
//  tvshows
//
//  Created by Aldair Martínez on 03/12/22.
//

import Foundation

class TvShowUserDefaults {
    private let defaults = UserDefaults.standard
    
    private let keyUsername = "username"
  
    var username: String? {
        set {
            if newValue != nil {
                defaults.set(newValue, forKey: keyUsername)
            } else {
                defaults.removeObject(forKey: keyUsername)
                defaults.synchronize()
            }
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
