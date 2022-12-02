//
//  CategoryType.swift
//  tvshows
//
//  Created by Aldair Martínez on 02/12/22.
//

import Foundation

protocol Category {
    var category: String { get }
}

enum CategoryType: Int, Category {
    
    case POPULAR = 0
    case TOP_RATED = 1
    case ON_TV = 2
    case AIRING_TODAY = 3
    
    var category: String {
        switch self {
        case .POPULAR:
            return "/tv/popular"
        case .TOP_RATED:
            return "/tv/top_rated"
        case .ON_TV:
            return "/tv/on_tv"
        case .AIRING_TODAY:
            return "/tv/airing_today"
        }
    }
    
}

