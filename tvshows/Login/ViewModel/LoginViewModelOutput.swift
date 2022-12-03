//
//  LoginViewModelOutput.swift
//  tvshows
//
//  Created by Aldair Martínez on 03/12/22.
//

import Foundation
import Combine

struct LoginViewModelOutput {
    let loadingPublisher = PassthroughSubject<Bool, Never>()
    let showErrorMessagePublisher = PassthroughSubject<String, Never>()
    let navigateToMainPublisher = PassthroughSubject<Void, Never>()
}
