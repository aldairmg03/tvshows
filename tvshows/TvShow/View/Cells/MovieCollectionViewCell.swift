//
//  MovieCollectionViewCell.swift
//  tvshows
//
//  Created by Aldair Martínez on 02/12/22.
//

import Foundation
import UIKit

class MovieCollectionViewCell: UICollectionViewCell {
 
    static let identifier = "MovieCollectionViewCell"
    
    private lazy var posterImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 16
        return imageView
    }()
    
    private lazy var stackViewVertical: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.distribution = .fillProportionally
        stackView.spacing = 8
        stackView.axis = .vertical
        return stackView
    }()
    
    private lazy var stackViewHorizontal: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.distribution = .fillProportionally
        stackView.spacing = 6
        stackView.axis = .horizontal
        return stackView
    }()
    
    private lazy var titleLabel: UILabel = {
        var label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var dateLabel: UILabel = {
        var label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var ratedLabel: UILabel = {
        var label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = UIColor(named: "textColor")
        label.font = UIFont.boldSystemFont(ofSize: 14)
        return label
    }()
    
    private lazy var descriptionLabel: UILabel = {
        var label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 4
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupCell()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        contentView.backgroundColor = UIColor(named: "cardColor")
    }
    
}

private extension MovieCollectionViewCell {
    
    func setupCell() {
        contentViewCornerRadius()
        addViews()
        setConstraints()
    }
    
    func contentViewCornerRadius() {
        contentView.layer.cornerRadius = 16.0
        contentView.layer.masksToBounds = true
        layer.cornerRadius = 16.0
        layer.masksToBounds = false
    }
    
    func addViews() {
        contentView.addSubview(posterImageView)
        contentView.addSubview(stackViewVertical)
        
        stackViewHorizontal.addArrangedSubview(dateLabel)
        stackViewHorizontal.addArrangedSubview(ratedLabel)
        
        stackViewVertical.addArrangedSubview(titleLabel)
        stackViewVertical.addArrangedSubview(stackViewHorizontal)
        stackViewVertical.addArrangedSubview(descriptionLabel)
    }
    
    func setConstraints() {
        NSLayoutConstraint.activate([
            posterImageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            posterImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            posterImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            posterImageView.widthAnchor.constraint(equalToConstant: (UIScreen.main.bounds.width / 2)),
            posterImageView.heightAnchor.constraint(equalToConstant: 180)
        ])
        
        NSLayoutConstraint.activate([
            stackViewVertical.topAnchor.constraint(equalTo: posterImageView.bottomAnchor, constant: 8),
            stackViewVertical.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 6),
            stackViewVertical.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -6),
            stackViewVertical.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8),
        ])
        
        
    }
    
}


extension MovieCollectionViewCell {
    
    
    public func configure(with tvShow: Movie) {
        if let posterPath = tvShow.posterPath, let url = URL(string: "https://image.tmdb.org/t/p/w500\(posterPath)") {
            posterImageView.load(url: url)
        } else {
            posterImageView.image = UIImage(named:"themoviedb")
        }
        titleLabel.text = tvShow.originalName
        if let airDate = airDateFormatter.date(from: tvShow.firstAirDate) {
            dateLabel.text = "\(dateFormatter.string(from: airDate).lowercased())"
        } else {
            dateLabel.text = tvShow.firstAirDate
        }
        
        let attachment = NSTextAttachment()
        let image = UIImage(systemName: "star.fill")
        image?.withTintColor(UIColor(named: "textColor")!)
        attachment.image = image

        let imageString = NSMutableAttributedString(attachment: attachment)
        let textString = NSAttributedString(string: " \(tvShow.voteAverage)")
        imageString.append(textString)

        ratedLabel.attributedText = imageString
        ratedLabel.sizeToFit()
        
        descriptionLabel.text = tvShow.overview ==  "" ? "\n\n\n\n" : tvShow.overview
        
        titleLabel.setStyle(textColor: UIColor(named: "textColor")!, size: 14)
        dateLabel.setStyle(textColor: UIColor(named: "textColor")!, size: 14)
        descriptionLabel.setStyle(textColor: .white, size: 12)
        
    }
    
}
