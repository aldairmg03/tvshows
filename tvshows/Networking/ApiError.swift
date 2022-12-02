//
//  ApiError.swift
//  tvshows
//
//  Created by Aldair Martínez on 02/12/22.
//

import Foundation

enum ApiError: Error {
    case parsing(description: String)
    case network(description: String)
  }
