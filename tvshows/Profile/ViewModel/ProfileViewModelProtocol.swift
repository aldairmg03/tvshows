//
//  ProfileViewModelProtocol.swift
//  tvshows
//
//  Created by Aldair Martínez on 04/12/22.
//

import Foundation

protocol ProfileViewModelProtocol: AnyObject {
    var output: ProfileViewModelOutput { get }
    func bind(input: ProfileViewModelInput) -> ProfileViewModelOutput
}
