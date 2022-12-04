//
//  MainViewController.swift
//  tvshows
//
//  Created by Aldair Martínez on 02/12/22.
//

import UIKit
import Combine

class MainViewController: UIViewController {
    
    public var movies: [Movie] = []
    
    private var subscriptions = Set<AnyCancellable>()
    private let viewModelInput = MainViewModelInput()
    let viewModel: MainViewModelProtocol
    
    private lazy var segmentedControl: UISegmentedControl = {
        let segmentedControl = UISegmentedControl(items: ["popular".localized, "top_rated".localized, "on_tv".localized, "airing_today".localized])
        segmentedControl.translatesAutoresizingMaskIntoConstraints = false
        segmentedControl.backgroundColor = UIColor(named: "segmentedColor")
        segmentedControl.selectedSegmentTintColor = UIColor(named: "segmentedSelectedColor")
        segmentedControl.selectedSegmentIndex = 0
        let titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor(named: "segmentedTextColor")!]
        segmentedControl.setTitleTextAttributes(titleTextAttributes, for: UIControl.State.normal)
        segmentedControl.setTitleTextAttributes(titleTextAttributes, for: UIControl.State.selected)
        segmentedControl.addTarget(self, action: #selector(segmentedValueChanged(_:)), for: .valueChanged)
        return segmentedControl
    }()
    
    public lazy var tvShowsCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: (UIScreen.main.bounds.width / 2) - 24, height: 310)
        layout.minimumInteritemSpacing = 0
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.register(MovieCollectionViewCell.self, forCellWithReuseIdentifier: MovieCollectionViewCell.identifier)
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
    
    init(viewModel: MainViewModelProtocol) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        bind()
        setup()
        fetchTvShows(index: 0)
    }
    
    @objc private func segmentedValueChanged(_ sender: UISegmentedControl!) {
        print("Selected Segment Index is : \(sender.selectedSegmentIndex)")
        fetchTvShows(index: sender.selectedSegmentIndex)
    }
    
    @objc func openTapped() {
        let ac = UIAlertController(title: "question".localized, message: nil, preferredStyle: .actionSheet)
        ac.addAction(UIAlertAction(title: "view_profile".localized, style: .default, handler: { _ in
            self.viewModelInput.navigateToProfilePublisher.send()
        }))
        ac.addAction(UIAlertAction(title: "log_out".localized, style: .destructive, handler: { _ in
            self.closeSession()
        }))
        ac.addAction(UIAlertAction(title: "cancel".localized, style: .cancel))
        ac.popoverPresentationController?.barButtonItem = self.navigationItem.rightBarButtonItem
        present(ac, animated: true)
    }

}


private extension MainViewController {
    
    func bind() {
        let output = viewModel.bind(input: viewModelInput)
        
        output.showLoadingPublisher.sink { [weak self] in
            self?.displayLoading()
        }.store(in: &subscriptions)

        output.dismissLoadingPublisher.sink { [weak self] in
            self?.dismissLoading()
        }.store(in: &subscriptions)
        
        output.tvShows.sink {[weak self] tvShows in
            self?.loadData(items: tvShows)
        }.store(in: &subscriptions)
    }
    
    func setup() {
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "list.dash"), style: .done, target: self, action: #selector(openTapped))
        title = "tv_shows".localized
        view.backgroundColor = UIColor(named: "mainColor")
        addViews()
        setConstraints()
    }
    
    func addViews() {
        view.addSubview(segmentedControl)
        view.addSubview(tvShowsCollectionView)
        loadingActivityIndicator.center = CGPoint(
            x: view.bounds.midX,
            y: view.bounds.midY
        )
        view.addSubview(loadingActivityIndicator)
    }
    
    func setConstraints() {
        NSLayoutConstraint.activate([
            segmentedControl.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 16),
            segmentedControl.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            segmentedControl.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20)
        ])
        
        NSLayoutConstraint.activate([
            tvShowsCollectionView.topAnchor.constraint(equalTo: segmentedControl.bottomAnchor, constant: 16),
            tvShowsCollectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            tvShowsCollectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            tvShowsCollectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -16)
        ])
    }
    
    func fetchTvShows(index: Int) {
        viewModelInput.fetchTvShowsPublisher.send(index)
    }
    
    func displayLoading() {
        loadingActivityIndicator.isHidden = false
    }
    
    func dismissLoading() {
        loadingActivityIndicator.isHidden = true
    }
    
    func loadData(items: [Movie]) {
        self.movies = items
        self.tvShowsCollectionView.reloadData()
        self.tvShowsCollectionView.setContentOffset(.zero, animated: true)
    }
    
    func closeSession() {
        let sceneDelegate = self.view.window?.windowScene?.delegate!
        self.viewModelInput.closeSessionPublisher.send(sceneDelegate!)
    }
    
}

extension MainViewController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let movie = movies[indexPath.row]
        viewModelInput.seeMovieDetailPublisher.send(movie.id)
        collectionView.deselectItem(at: indexPath, animated: true)
    }
    
}

extension MainViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return movies.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MovieCollectionViewCell.identifier, for: indexPath) as? MovieCollectionViewCell else {
            return UICollectionViewCell()
        }
        let movie = movies[indexPath.row]
        cell.configure(with: movie)
        return cell
    }
    
    
}
