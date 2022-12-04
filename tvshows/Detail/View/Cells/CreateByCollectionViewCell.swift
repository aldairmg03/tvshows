//
//  CreateByCollectionViewCell.swift
//  tvshows
//
//  Created by Aldair Martínez on 04/12/22.
//

import UIKit

class CreateByCollectionViewCell: UICollectionViewCell {
    static let identifier = "CreateByCollectionViewCell"
    
    private lazy var stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 6
        stackView.distribution = .fill
        return stackView
    }()
    
    private lazy var profileImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        return imageView
    }()
    private lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.numberOfLines = 1
        label.textAlignment = .center
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupCell()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func configure(with createBy: CreatedBy) {
        if let profilePath = createBy.profilePath, let url = URL(string: "https://image.tmdb.org/t/p/w500\(profilePath)") {
            profileImageView.load(url: url)
        } else {
            profileImageView.image = UIImage(named:"themoviedb")
        }
        nameLabel.text = createBy.name
        nameLabel.setStyle(textColor: .white, size: 10)
    }
    
}

private extension CreateByCollectionViewCell {
    
    func setupCell () {
        addViews()
        
        profileImageView.frame = CGRect(x: 0, y: 0, width: 50, height: 50)
        profileImageView.layer.cornerRadius = 8
        stackView.frame = CGRect(x: 0, y: 0, width: 70, height: 70)
    }
    func addViews() {
        stackView.addArrangedSubviews(profileImageView, nameLabel)
        contentView.addSubview(stackView)
    }
    
}

