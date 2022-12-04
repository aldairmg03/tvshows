//
//  DetailViewModelProtocol.swift
//  tvshows
//
//  Created by Aldair Martínez on 03/12/22.
//

import Foundation

protocol DetailViewModelProtocol: AnyObject {
    var output: DetailViewModelOutput { get }
    func bind(input: DetailViewModelInput) -> DetailViewModelOutput
}
