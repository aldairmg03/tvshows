//
//  ProfileViewModel.swift
//  tvshows
//
//  Created by Aldair Martínez on 04/12/22.
//

import Foundation
import Combine

final class ProfileViewModel: ProfileViewModelProtocol {
    
    var output = ProfileViewModelOutput()
    private var subscriptions = Set<AnyCancellable>()
    
    func bind(input: ProfileViewModelInput) -> ProfileViewModelOutput {
        
        input.getUsernamePublisher.sink(receiveValue: { [weak self] in
            self?.getUsername()
        }).store(in: &subscriptions)
        
        return output
    }
    
    private func getUsername() {
        guard let username = TvShowUserDefaults.shared.username else {
            self.output.usernamePublisher.send("unknow")
            return
        }
        self.output.usernamePublisher.send(username)
    }
    
}
