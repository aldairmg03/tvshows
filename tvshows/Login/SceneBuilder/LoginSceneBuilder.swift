//
//  LoginSceneBuilder.swift
//  tvshows
//
//  Created by Aldair Martínez on 04/12/22.
//

import Foundation

class LoginSceneBuilder {
    
    func build() -> LoginViewController {
        let loginRepository = LoginRepository()
        let loginUseCase = LoginUseCase(repository: loginRepository)
        let loginViewModel = LoginViewModel(loginUseCase: loginUseCase)
        let loginViewController = LoginViewController(viewModel: loginViewModel)
        return loginViewController
    }
    
}
