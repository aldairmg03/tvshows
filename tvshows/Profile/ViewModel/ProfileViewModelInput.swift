//
//  ProfileViewModelInput.swift
//  tvshows
//
//  Created by Aldair Martínez on 04/12/22.
//

import Foundation
import Combine

struct ProfileViewModelInput {
    let getUsernamePublisher = PassthroughSubject<Void, Never>()
}
