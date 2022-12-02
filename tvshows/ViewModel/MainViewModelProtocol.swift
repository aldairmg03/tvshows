//
//  MainViewModelProtocol.swift
//  tvshows
//
//  Created by Aldair Martínez on 02/12/22.
//

import Foundation

protocol MainViewModelProtocol: AnyObject {
    var output: MainViewModelOutput { get }
    func bind(input: MainViewModelInput) -> MainViewModelOutput
}
