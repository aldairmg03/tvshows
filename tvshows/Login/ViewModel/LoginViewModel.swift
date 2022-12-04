//
//  LoginViewModel.swift
//  tvshows
//
//  Created by Aldair Martínez on 03/12/22.
//

import Foundation
import Combine

final class LoginViewModel: LoginViewModelProtocol {
    
    private let loginUseCase: LoginUseCaseProtocol
    let output = LoginViewModelOutput()
    private var subscriptions = Set<AnyCancellable>()
    
    init(loginUseCase: LoginUseCaseProtocol) {
        self.loginUseCase = loginUseCase
    }
    
    func bind(input: LoginViewModelInput) -> LoginViewModelOutput {
        
        input.startLoginPublisher.sink {[weak self] user in
            self?.requestToken(with: user)
        }.store(in: &subscriptions)
        
        input.navigateToMainPublisher.sink {[weak self] sceneDelegate in
            self?.output.navigateToMainPublisher.send(sceneDelegate)
        }.store(in: &subscriptions)
        
        return output
    }
    
    private func requestToken(with user: User) {
        self.output.loadingPublisher.send(true)
        self.loginUseCase.createRequestToken()
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { [weak self] value in
                self?.output.loadingPublisher.send(false)
            }, receiveValue: { [weak self] response in
                guard let requestToken = response.requestToken else {
                    return
                }
                self?.authentication(with: user, requestToken: requestToken)
            })
            .store(in: &subscriptions)
    }
    
    private func authentication(with user: User, requestToken: String?) {
        guard let requestToken = requestToken else { return }
        let auth = Authentication(username: user.username, password: user.password, requestToken: requestToken)
        self.loginUseCase.authentication(auth: auth)
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { [weak self] value in
                self?.output.loadingPublisher.send(false)
            }, receiveValue: { [weak self] response in
                if response.statusMessage != nil {
                    self?.output.showErrorMessagePublisher.send(response.statusMessage!)
                } else {
                    TvShowUserDefaults.shared.username = user.username
                    self?.output.successLoginPublisher.send()
                }
            })
            .store(in: &subscriptions)
    }
    
}
