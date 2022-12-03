//
//  LoginViewModel.swift
//  tvshows
//
//  Created by Aldair Martínez on 03/12/22.
//

import Foundation
import Combine

final class LoginViewModel: LoginViewModelProtocol {
    
    let output = LoginViewModelOutput()
    private var subscriptions = Set<AnyCancellable>()
    
    func bind(input: LoginViewModelInput) -> LoginViewModelOutput {
        
        input.startLoginPublisher.sink {[weak self] user in
            self?.requestToken(with: user)
        }.store(in: &subscriptions)
        
        return output
    }
    
    private func requestToken(with user: User) {
        self.output.loadingPublisher.send(true)
        ApiManager.shared.createRequestToken()
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
        ApiManager.shared.authentication(auth: auth)
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { [weak self] value in
                self?.output.loadingPublisher.send(false)
            }, receiveValue: { [weak self] response in
                if response.statusMessage != nil {
                    self?.output.showErrorMessagePublisher.send(response.statusMessage!)
                } else {
                    TvShowUserDefaults.shared.requestToken = response.requestToken!
                    TvShowUserDefaults.shared.username = user.username
                    self?.output.navigateToMainPublisher.send()
                }
            })
            .store(in: &subscriptions)
    }
    
}
