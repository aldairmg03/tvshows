//
//  DetailViewController.swift
//  tvshows
//
//  Created by Aldair Martínez on 03/12/22.
//

import UIKit
import Combine

class DetailViewController: UIViewController {
    
    private var productionsCompanies: [ProductionCompany] = []
    private var autors: [CreatedBy] = []
    
    private var subscriptions = Set<AnyCancellable>()
    private let viewModelInput = DetailViewModelInput()
    private let viewModel: DetailViewModelProtocol
    
    private lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        return scrollView
    }()
    
    private lazy var mainView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    
    private lazy var backdropImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 5
        return label
    }()
    
    private lazy var genresLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
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
        label.numberOfLines = 0
        return label
    }()
    
    private lazy var productionCompinesLabel: UILabel = {
        var label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var autorsLabel: UILabel = {
        var label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    public lazy var productionCompaniesCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let sizeView = (UIScreen.main.bounds.width / 4) - 12
        layout.itemSize = CGSize(width: sizeView, height: sizeView)
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
    
    public lazy var createByCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let sizeView = 70
        layout.itemSize = CGSize(width: sizeView, height: sizeView)
        layout.minimumInteritemSpacing = 0
        layout.scrollDirection = .horizontal
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.register(CreateByCollectionViewCell.self, forCellWithReuseIdentifier: CreateByCollectionViewCell.identifier)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.backgroundColor = UIColor(named: "mainColor")
        return collectionView
    }()
    
    private lazy var loadingActivityIndicator: UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView()
        indicator.style = .large
        indicator.color = .lightGray
        indicator.startAnimating()
        indicator.autoresizingMask = [
            .flexibleLeftMargin, .flexibleRightMargin,
            .flexibleTopMargin, .flexibleBottomMargin
        ]
        return indicator
    }()
    
    init(viewModel: DetailViewModelProtocol) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        bind()
        viewModelInput.getDetailPublisher.send()
    }

}

private extension DetailViewController {
    
    func bind() {
        let output = viewModel.bind(input: viewModelInput)
        
        output.showLoadingPublisher.sink { [weak self] show in
            self?.displayLoading(show: show)
        }.store(in: &subscriptions)
        
        output.movieDetail.sink { [weak self] movieDetail in
            self?.configure(with: movieDetail)
        }.store(in: &subscriptions)
    }
    
    func setup() {
        view.backgroundColor = UIColor(named: "mainColor")
        
        loadingActivityIndicator.center = CGPoint(
            x: view.bounds.midX,
            y: view.bounds.midY
        )
        
        
        addViews()
        setupScrollView()
        setConstraints()
        setStyles()
    }
    
    func setupScrollView() {
    }
    
    func addViews() {
        view.addSubview(scrollView)
        scrollView.addSubview(mainView)
        mainView.addSubview(backdropImageView)
        mainView.addSubview(titleLabel)
        mainView.addSubview(genresLabel)
        mainView.addSubview(descriptionLabel)
        mainView.addSubview(createByCollectionView)
        mainView.addSubview(autorsLabel)
        mainView.addSubview(productionCompinesLabel)
        mainView.addSubview(productionCompaniesCollectionView)
        mainView.addSubview(loadingActivityIndicator)
    }
    
    func setConstraints() {
        NSLayoutConstraint.activate([
            scrollView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            scrollView.widthAnchor.constraint(equalTo: view.widthAnchor),
            scrollView.topAnchor.constraint(equalTo: view.topAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])

        NSLayoutConstraint.activate([
            mainView.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor),
            mainView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
            mainView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            mainView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor)
        ])
        
        NSLayoutConstraint.activate([
            backdropImageView.topAnchor.constraint(equalTo: mainView.topAnchor),
            backdropImageView.leadingAnchor.constraint(equalTo: mainView.leadingAnchor),
            backdropImageView.trailingAnchor.constraint(equalTo: mainView.trailingAnchor),
            backdropImageView.widthAnchor.constraint(equalToConstant: (UIScreen.main.bounds.width)),
            backdropImageView.heightAnchor.constraint(equalToConstant: (UIScreen.main.bounds.height / 3)),
        ])
        
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: backdropImageView.bottomAnchor, constant: 16),
            titleLabel.leadingAnchor.constraint(equalTo: mainView.leadingAnchor, constant: 16),
            titleLabel.trailingAnchor.constraint(equalTo: mainView.trailingAnchor, constant: -16)
        ])
        
        NSLayoutConstraint.activate([
            genresLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 12),
            genresLabel.leadingAnchor.constraint(equalTo: mainView.leadingAnchor, constant: 16),
            genresLabel.trailingAnchor.constraint(equalTo: mainView.trailingAnchor, constant: -16)
        ])
        
        NSLayoutConstraint.activate([
            descriptionLabel.topAnchor.constraint(equalTo: genresLabel.bottomAnchor, constant: 12),
            descriptionLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            descriptionLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16)
        ])
        
        NSLayoutConstraint.activate([
            autorsLabel.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor, constant: 12),
            autorsLabel.leadingAnchor.constraint(equalTo: mainView.leadingAnchor, constant: 16),
            autorsLabel.trailingAnchor.constraint(equalTo: mainView.trailingAnchor, constant: -16)
        ])
        
        NSLayoutConstraint.activate([
            createByCollectionView.topAnchor.constraint(equalTo: autorsLabel.bottomAnchor, constant: 4),
            createByCollectionView.leadingAnchor.constraint(equalTo: mainView.leadingAnchor, constant: 16),
            createByCollectionView.trailingAnchor.constraint(equalTo: mainView.trailingAnchor, constant: -16),
            createByCollectionView.heightAnchor.constraint(equalToConstant: 70)
        ])
        
        NSLayoutConstraint.activate([
            productionCompinesLabel.topAnchor.constraint(equalTo: createByCollectionView.bottomAnchor, constant: 12),
            productionCompinesLabel.leadingAnchor.constraint(equalTo: mainView.leadingAnchor, constant: 16),
            productionCompinesLabel.trailingAnchor.constraint(equalTo: mainView.trailingAnchor, constant: -16)
        ])
        
        NSLayoutConstraint.activate([
            productionCompaniesCollectionView.topAnchor.constraint(equalTo: productionCompinesLabel.bottomAnchor, constant: 4),
            productionCompaniesCollectionView.leadingAnchor.constraint(equalTo: mainView.leadingAnchor, constant: 16),
            productionCompaniesCollectionView.trailingAnchor.constraint(equalTo: mainView.trailingAnchor, constant: -16),
            productionCompaniesCollectionView.bottomAnchor.constraint(equalTo: mainView.bottomAnchor, constant: -16),
            productionCompaniesCollectionView.heightAnchor.constraint(equalToConstant: (UIScreen.main.bounds.width / 4))
        ])
        
    }
    
}

extension DetailViewController {
    
    private func configure(with movieDetail: MovieDetail) {
        productionsCompanies = movieDetail.productionCompanies
        productionCompaniesCollectionView.reloadData()
        
        autors = movieDetail.createdBy ?? []
        createByCollectionView.reloadData()
        if let backdropPath = movieDetail.backdropPath, let url = URL(string: "https://image.tmdb.org/t/p/w500\(backdropPath)") {
            backdropImageView.load(url: url)
        } else {
            backdropImageView.image = UIImage(named:"themoviedb")
        }
        
        titleLabel.text = "\(movieDetail.originalName) (\(movieDetail.firstAirDate))"
        descriptionLabel.text = "Overview\n\n\(movieDetail.overview)"
        
        var genresConcat = ""
        movieDetail.genres.forEach { genre in
            genresConcat.append("\(genre.name)")
            genresConcat.append(movieDetail.genres.last?.name != genre.name ? ", ": "")
        }
        genresLabel.text = genresConcat
        autorsLabel.text = "autors".localized
        productionCompinesLabel.text = "production_companies".localized
        
        setStyles()
    }
    
    private func setupStackViewGenres(genres: [Genre]) {
        stackViewGenres.removeViews()
        genres.forEach { genre in
            let genreView = GenresView()
            genreView.configure(text: genre.name)
            stackViewGenres.addArrangedSubviews(genreView)
        }
        
    }
    
    func setStyles() {
        titleLabel.setStyle(textColor: .white, size: 22)
        descriptionLabel.setStyle(textColor: .white, size: 14)
        genresLabel.setStyle(textColor: UIColor(named: "textColor")!, size: 14)
        autorsLabel.setStyle(textColor: .white, size: 14)
        productionCompinesLabel.setStyle(textColor: .white, size: 14)
    }
    
    private func displayLoading(show: Bool) {
        if show {
            loadingActivityIndicator.startAnimating()
        } else {
            loadingActivityIndicator.stopAnimating()
        }
        loadingActivityIndicator.isHidden = !show
    }
    
}

extension DetailViewController: UICollectionViewDelegate {
    
}

extension DetailViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return collectionView == self.productionCompaniesCollectionView ? productionsCompanies.count : autors.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if collectionView == self.productionCompaniesCollectionView {
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ProductionCompanieCollectionViewCell.identifier, for: indexPath) as? ProductionCompanieCollectionViewCell else { return UICollectionViewCell() }
            let productionCompany = productionsCompanies[indexPath.row]
            cell.configure(with: productionCompany)
            return cell
        } else {
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CreateByCollectionViewCell.identifier, for: indexPath) as? CreateByCollectionViewCell else { return UICollectionViewCell() }
            let autor = autors[indexPath.row]
            cell.configure(with: autor)
            return cell
        }
        
    }
    
}
