//
//  GenresView.swift
//  tvshows
//
//  Created by Aldair Martínez on 03/12/22.
//

import Foundation
import UIKit

class GenresView: UIView {
    
    private lazy var genreLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .white
        label.font = UIFont.boldSystemFont(ofSize: 14)
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(text: String) {
        genreLabel.text = text
    }
    
}

private extension GenresView {
 
    func setupView() {
        backgroundColor = UIColor(named: "textColor")
        layer.cornerRadius = 6
        addViews()
        setConstraints()
    }

    func addViews() {
        addSubview(genreLabel)
    }

    func setConstraints() {
        NSLayoutConstraint.activate([
            heightAnchor.constraint(equalToConstant: 20)
        ])
        
        NSLayoutConstraint.activate([
            genreLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
            genreLabel.centerXAnchor.constraint(equalTo: centerXAnchor)
        ])
    }
}
