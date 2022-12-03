//
//  ProfileViewController.swift
//  tvshows
//
//  Created by Aldair Martínez on 02/12/22.
//

import UIKit

class ProfileViewController: UIViewController {

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
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }

}

private extension ProfileViewController  {
    
    func setupView() {
        view.backgroundColor = UIColor(named: "mainColor")
        addViews()
        setConstraints()
        configure()
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
    func configure() {
        profileLabel.text = "profile".localized
        nicknameLabel.text = "@nickname"
        profileLabel.setStyle(textColor: UIColor(named: "textColor")!, size: 24)
        nicknameLabel.setStyle(textColor: UIColor(named: "textColor")!, size: 16)
    }
    
}
