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
    /*
     imageView.contentMode = .scaleAspectFill
     imageView.clipsToBounds = true*/
    
    private lazy var companieLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 2
        label.textColor = .systemOrange
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.backgroundColor = .white
        setupCell()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        productionCompanieImageView.frame = contentView.bounds
    }
    
    public func configure(with logoPath: String) {
        guard let url = URL(string: "https://image.tmdb.org/t/p/w500\(logoPath)") else { return }
        productionCompanieImageView.load(url: url)
        companieLabel.text = "Companie Companie"
        //companieLabel.setStyle(textColor: UIColor(named: "textColor")!, size: 14)
    }
    
}

private extension ProductionCompanieCollectionViewCell {
    
    func setupCell () {
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
        contentView.addSubview(productionCompanieImageView)
        contentView.addSubview(companieLabel)
    }
    
    func setConstraints() {
        
        //  CGSize(width: (UIScreen.main.bounds.width / 4) - 12, height: (UIScreen.main.bounds.width / 4) - 12)
        NSLayoutConstraint.activate([
            productionCompanieImageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            productionCompanieImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            productionCompanieImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            productionCompanieImageView.widthAnchor.constraint(equalToConstant: 100),
            productionCompanieImageView.heightAnchor.constraint(equalToConstant: 100)
        ])
        
        NSLayoutConstraint.activate([
            companieLabel.topAnchor.constraint(equalTo: productionCompanieImageView.bottomAnchor, constant: 4),
            companieLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            companieLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            companieLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            companieLabel.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
    
}
