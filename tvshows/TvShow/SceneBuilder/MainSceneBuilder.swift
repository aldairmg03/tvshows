//
//  MainSceneBuilder.swift
//  tvshows
//
//  Created by Aldair Martínez on 04/12/22.
//

import Foundation

class MainSceneBuilder {
    
    func build() -> MainViewController {
        let mainRepository = MainRepository()
        let mainUseCase = MainUseCase(repository: mainRepository)
        let mainViewModel = MainViewModel(mainUseCase: mainUseCase)
        let mainViewController = MainViewController(viewModel: mainViewModel)
        return mainViewController
    }
    
}
