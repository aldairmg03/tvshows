//
//  ProfileViewController.swift
//  tvshows
//
//  Created by Aldair Martínez on 02/12/22.
//

import UIKit
import Combine

class ProfileViewController: UIViewController {

    private var subscriptions = Set<AnyCancellable>()
    private let viewModelInput = ProfileViewModelInput()
    private let viewModel: ProfileViewModelProtocol
    
    private lazy var profileLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var profileImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(named: "avatar")
        imageView.clipsToBounds = true
        return imageView
    }()
    
    private lazy var nicknameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    init(viewModel: ProfileViewModelProtocol) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bind()
        setupView()
        getUsername()
    }

}

private extension ProfileViewController  {
    
    func bind() {
        let output = viewModel.bind(input: viewModelInput)
        
        output.usernamePublisher.sink { [weak self] username in
            self?.configure(with: username)
        }.store(in: &subscriptions)
        
    }
    
    func setupView() {
        view.backgroundColor = UIColor(named: "mainColor")
        addViews()
        setConstraints()
    }
    
    func addViews() {
        view.addSubview(profileLabel)
        view.addSubview(profileImageView)
        view.addSubview(nicknameLabel)
    }
    
    func setConstraints() {
        NSLayoutConstraint.activate([
            profileLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 48),
            profileLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 32)
        ])
        
        NSLayoutConstraint.activate([
            profileImageView.topAnchor.constraint(equalTo: profileLabel.bottomAnchor, constant: 40),
            profileImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 40),
            profileImageView.heightAnchor.constraint(equalToConstant: 120),
            profileImageView.widthAnchor.constraint(equalToConstant: 120)
        ])
        
        NSLayoutConstraint.activate([
            nicknameLabel.centerYAnchor.constraint(equalTo: profileImageView.centerYAnchor),
            nicknameLabel.leadingAnchor.constraint(equalTo: profileImageView.trailingAnchor, constant: 32),
            nicknameLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -32)
        ])
    }
    
}

extension ProfileViewController {
    
    private func getUsername() {
        self.viewModelInput.getUsernamePublisher.send()
    }
    
    private func configure(with username: String) {
        profileLabel.text = "profile".localized
        nicknameLabel.text = "at".localized + username
        profileLabel.setStyle(textColor: UIColor(named: "textColor")!, size: 24)
        nicknameLabel.setStyle(textColor: UIColor(named: "textColor")!, size: 16)
    }
    
}
