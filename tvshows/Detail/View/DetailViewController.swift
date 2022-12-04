//
//  DetailViewController.swift
//  tvshows
//
//  Created by Aldair Martínez on 03/12/22.
//

import UIKit

class DetailViewController: UIViewController {
    
    private var productionsCompanies: [String] = ["/9RO2vbQ67otPrBLXCaC8UMp3Qat.png", "/h3syDHowNmk61FzlW2GPY0vJCFh.png", "/9RO2vbQ67otPrBLXCaC8UMp3Qat.png", "/h3syDHowNmk61FzlW2GPY0vJCFh.png", "/9RO2vbQ67otPrBLXCaC8UMp3Qat.png", "/h3syDHowNmk61FzlW2GPY0vJCFh.png",]
    
    private lazy var backdropImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(named: "banner")
        return imageView
    }()

    private lazy var posterImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(named: "banner")
        imageView.clipsToBounds = true
        return imageView
    }()
    
    private lazy var titleLabel: UILabel = {
        var label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 5
        return label
    }()
    
    private lazy var ratedLabel: UILabel = {
        var label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var stackViewGenres: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.distribution = .fillProportionally
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.spacing = 4
        return stackView
    }()
    
    private lazy var descriptionLabel: UILabel = {
        var label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 8
        return label
    }()
    
    public lazy var productionCompaniesCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: 100, height: 150 )
        layout.minimumInteritemSpacing = 0
        layout.scrollDirection = .horizontal
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.register(ProductionCompanieCollectionViewCell.self, forCellWithReuseIdentifier: ProductionCompanieCollectionViewCell.identifier)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.backgroundColor = UIColor(named: "mainColor")
        return collectionView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }

}

private extension DetailViewController {
    
    func setup() {
        view.backgroundColor = UIColor(named: "mainColor")
        addViews()
        setConstraints()
        setupStackViewGenres(genres: ["Drama", "Action", "Mystery", "Drama", "Action", "Mystery", ])
        setStyles()
    }
    
    func addViews() {
        view.addSubview(backdropImageView)
        view.addSubview(posterImageView)
        view.addSubview(titleLabel)
        view.addSubview(ratedLabel)
        view.addSubview(stackViewGenres)
        view.addSubview(descriptionLabel)
        view.addSubview(productionCompaniesCollectionView)
    }
    
    func setConstraints() {
        NSLayoutConstraint.activate([
            backdropImageView.topAnchor.constraint(equalTo: view.topAnchor),
            backdropImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            backdropImageView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            backdropImageView.widthAnchor.constraint(equalToConstant: (UIScreen.main.bounds.width)),
            backdropImageView.heightAnchor.constraint(equalToConstant: (UIScreen.main.bounds.height / 3)),
        ])
        
        NSLayoutConstraint.activate([
            posterImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            posterImageView.centerYAnchor.constraint(equalTo: backdropImageView.centerYAnchor),
            posterImageView.heightAnchor.constraint(equalToConstant: ((UIScreen.main.bounds.height / 3) - 60)),
            posterImageView.widthAnchor.constraint(equalToConstant: 150)
        ])
        
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: posterImageView.topAnchor, constant: 22),
            titleLabel.leadingAnchor.constraint(equalTo: posterImageView.trailingAnchor, constant: 16),
            titleLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16)
        ])
        
        NSLayoutConstraint.activate([
            ratedLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 12),
            ratedLabel.leadingAnchor.constraint(equalTo: posterImageView.trailingAnchor, constant: 16),
            ratedLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16)
        ])
        
        NSLayoutConstraint.activate([
            stackViewGenres.topAnchor.constraint(equalTo: backdropImageView.bottomAnchor),
            stackViewGenres.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            stackViewGenres.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16)
        ])
        
        NSLayoutConstraint.activate([
            descriptionLabel.topAnchor.constraint(equalTo: stackViewGenres.bottomAnchor, constant: 32),
            descriptionLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            descriptionLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16)
        ])
        
        NSLayoutConstraint.activate([
            productionCompaniesCollectionView.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor, constant: 32),
            productionCompaniesCollectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            productionCompaniesCollectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            productionCompaniesCollectionView.heightAnchor.constraint(equalToConstant: 150)
        ])
        
    }
    
    func setStyles() {
        titleLabel.text = "Game of Thrones a Game of Thrones ye Game of Thrones Game of Thrones"
        ratedLabel.text = "8.9"
        descriptionLabel.text = "Seven noble families fight for control of the mythical land of Westeros. Friction between the houses leads to full-scale war. All while a very ancient evil awakens in the farthest north. Amidst the war, a neglected military order of misfits, the Night's Watch, is all that stands between the realms of men and icy horrors beyond."
        titleLabel.setStyle(textColor: .white, size: 22)
        ratedLabel.setStyle(textColor: UIColor(named: "textColor")!, size: 18)
        descriptionLabel.setStyle(textColor: .white, size: 16)
    }
    
}

extension DetailViewController {
    
    private func setupStackViewGenres(genres: [String]) {
        stackViewGenres.removeViews()
        genres.forEach { genre in
            let genreView = GenresView()
            genreView.configure(text: genre)
            stackViewGenres.addArrangedSubviews(genreView)
        }
    }
    
}

extension DetailViewController: UICollectionViewDelegate {
    
}

extension DetailViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return productionsCompanies.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ProductionCompanieCollectionViewCell.identifier, for: indexPath) as? ProductionCompanieCollectionViewCell else { return UICollectionViewCell() }
        let posterPath = productionsCompanies[indexPath.row]
        cell.configure(with: posterPath)
        return cell
    }
    
}
