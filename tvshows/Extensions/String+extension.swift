//
//  String+extension.swift
//  tvshows
//
//  Created by Aldair Martínez on 02/12/22.
//

import Foundation

extension String {
    
    var localized: String {
        return NSLocalizedString(self, tableName: nil, bundle: Bundle.main, value: "", comment: "")
    }
    
}
