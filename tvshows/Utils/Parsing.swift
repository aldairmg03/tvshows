//
//  Parsing.swift
//  tvshows
//
//  Created by Aldair Martínez on 02/12/22.
//

import Foundation

import Combine

func decode<T: Decodable>(_ data: Data) -> AnyPublisher<T, ApiError> {
  let decoder = JSONDecoder()
  decoder.dateDecodingStrategy = .secondsSince1970

  return Just(data)
    .decode(type: T.self, decoder: decoder)
    .mapError { error in
      .parsing(description: error.localizedDescription)
    }
    .eraseToAnyPublisher()
}
