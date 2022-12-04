//
//  ProfileSceneBuilder.swift
//  tvshows
//
//  Created by Aldair Martínez on 04/12/22.
//

import Foundation

class ProfileSceneBuilder {
    
    func bind() -> ProfileViewController {
        let profileViewModel = ProfileViewModel()
        let profileViewController = ProfileViewController(viewModel: profileViewModel)
        return profileViewController
    }
    
}
