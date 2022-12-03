//
//  LoginViewModelInput.swift
//  tvshows
//
//  Created by Aldair Martínez on 03/12/22.
//

import Foundation
import Combine

struct LoginViewModelInput {
    let startLoginPublisher = PassthroughSubject<User, Never>()
}
