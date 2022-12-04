//
//  ProfileViewModelOutput.swift
//  tvshows
//
//  Created by Aldair Martínez on 04/12/22.
//

import Foundation
import Combine

struct ProfileViewModelOutput {
    let usernamePublisher = PassthroughSubject<String, Never>()
}
