//
//  MainSceneBuilder.swift
//  tvshows
//
//  Created by Aldair Martínez on 04/12/22.
//

import Foundation

class MainSceneBuilder {
    
    func build() -> MainViewController {
        let mainViewModel = MainViewModel()
        let mainViewController = MainViewController(viewModel: mainViewModel)
        return mainViewController
    }
    
}
