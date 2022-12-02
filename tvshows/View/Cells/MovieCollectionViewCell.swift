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
        imageView.frame = CGRect(x: 0, y: 0, width: (UIScreen.main.bounds.width / 2) - 24, height: 180)
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    lazy var title: UILabel = {
        var label = UILabel()
        //label.setTe
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.addSubview(posterImageView)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        contentView.backgroundColor = UIColor(named: "cardColor")
        posterImageView.frame = contentView.bounds
    }
    
    public func configure(with posterPath: String) {
        guard let url = URL(string: "https://image.tmdb.org/t/p/w500\(posterPath)") else { return }
        //posterImageView.sd_setImage(with: url)
        
    }
    
}
