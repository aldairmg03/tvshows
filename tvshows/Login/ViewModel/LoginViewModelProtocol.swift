//
//  LoginViewModelProtocol.swift
//  tvshows
//
//  Created by Aldair Martínez on 03/12/22.
//

import Foundation
import Combine

protocol LoginViewModelProtocol: AnyObject {
    var output: LoginViewModelOutput { get }
    func bind(input: LoginViewModelInput) -> LoginViewModelOutput
}
