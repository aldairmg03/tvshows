//
//  ProductionCompanieCollectionViewCell.swift
//  tvshows
//
//  Created by Aldair Martínez on 03/12/22.
//

import UIKit

class ProductionCompanieCollectionViewCell: UICollectionViewCell {
 
    static let identifier = "ProductionCompanieCollectionViewCell"
    
   
    private lazy var productionCompanieImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
        return imageView
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
        productionCompanieImageView.frame = contentView.bounds
    }
    
    public func configure(with productionCompany: ProductionCompany) {
        if let logoPath = productionCompany.logoPath, let url = URL(string: "https://image.tmdb.org/t/p/w500\(logoPath)") {
            productionCompanieImageView.load(url: url)
        } else {
            productionCompanieImageView.image = UIImage(named:"themoviedb")
        }
    }
    
}

private extension ProductionCompanieCollectionViewCell {
    
    func setupCell () {
        contentView.backgroundColor = UIColor(named: "cardColor")
        contentViewCornerRadius()
        addViews()
    }
    
    func contentViewCornerRadius() {
        contentView.layer.cornerRadius = 16.0
        contentView.layer.masksToBounds = true
        layer.cornerRadius = 16.0
        layer.masksToBounds = false
    }
    
    func addViews() {
        contentView.addSubview(productionCompanieImageView)
    }
    
}
