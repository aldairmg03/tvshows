//
//  MainViewController.swift
//  tvshows
//
//  Created by Aldair Martínez on 02/12/22.
//

import UIKit

class MainViewController: UIViewController {
    
    public var movies: [Movie] = [
        Movie(posterPath: nil, popularity: 0.0, id: 1, backdropPath: "", voteAverage: 0.0, overview: "", firstAirDate: "", originCountry: [""], genreIDS: [1], originalLanguage: "", voteCount: 1, name: "", originalName: ""),
        Movie(posterPath: nil, popularity: 0.0, id: 1, backdropPath: "", voteAverage: 0.0, overview: "", firstAirDate: "", originCountry: [""], genreIDS: [1], originalLanguage: "", voteCount: 1, name: "", originalName: ""),
        Movie(posterPath: nil, popularity: 0.0, id: 1, backdropPath: "", voteAverage: 0.0, overview: "", firstAirDate: "", originCountry: [""], genreIDS: [1], originalLanguage: "", voteCount: 1, name: "", originalName: ""),
        Movie(posterPath: nil, popularity: 0.0, id: 1, backdropPath: "", voteAverage: 0.0, overview: "", firstAirDate: "", originCountry: [""], genreIDS: [1], originalLanguage: "", voteCount: 1, name: "", originalName: ""),
        Movie(posterPath: nil, popularity: 0.0, id: 1, backdropPath: "", voteAverage: 0.0, overview: "", firstAirDate: "", originCountry: [""], genreIDS: [1], originalLanguage: "", voteCount: 1, name: "", originalName: ""),
        Movie(posterPath: nil, popularity: 0.0, id: 1, backdropPath: "", voteAverage: 0.0, overview: "", firstAirDate: "", originCountry: [""], genreIDS: [1], originalLanguage: "", voteCount: 1, name: "", originalName: ""),
        Movie(posterPath: nil, popularity: 0.0, id: 1, backdropPath: "", voteAverage: 0.0, overview: "", firstAirDate: "", originCountry: [""], genreIDS: [1], originalLanguage: "", voteCount: 1, name: "", originalName: ""),
        Movie(posterPath: nil, popularity: 0.0, id: 1, backdropPath: "", voteAverage: 0.0, overview: "", firstAirDate: "", originCountry: [""], genreIDS: [1], originalLanguage: "", voteCount: 1, name: "", originalName: "")
    ]
    
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
    
    public lazy var searchResultsCollecitonView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: (UIScreen.main.bounds.width / 2) - 24, height: 250)
        layout.minimumInteritemSpacing = 0
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.register(MovieCollectionViewCell.self, forCellWithReuseIdentifier: MovieCollectionViewCell.identifier)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.backgroundColor = UIColor(named: "mainColor")
        return collectionView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    
    @objc private func segmentedValueChanged(_ sender: UISegmentedControl!) {
        print("Selected Segment Index is : \(sender.selectedSegmentIndex)")
    }
    
    @objc func openTapped() {
        let ac = UIAlertController(title: "question".localized, message: nil, preferredStyle: .actionSheet)
        ac.addAction(UIAlertAction(title: "view_profile".localized, style: .default, handler: nil))
        ac.addAction(UIAlertAction(title: "log_out".localized, style: .destructive, handler: nil))
        ac.addAction(UIAlertAction(title: "cancel".localized, style: .cancel))
        ac.popoverPresentationController?.barButtonItem = self.navigationItem.rightBarButtonItem
        present(ac, animated: true)
    }

}


private extension MainViewController {
    
    func setup() {
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "list.dash"), style: .done, target: self, action: #selector(openTapped))
        title = "tv_shows".localized
        view.backgroundColor = UIColor(named: "mainColor")
        addViews()
        setConstraints()
    }
    
    func addViews() {
        view.addSubview(segmentedControl)
        view.addSubview(searchResultsCollecitonView)
    }
    
    func setConstraints() {
        NSLayoutConstraint.activate([
            segmentedControl.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 16),
            segmentedControl.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            segmentedControl.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20)
        ])
        
        NSLayoutConstraint.activate([
            searchResultsCollecitonView.topAnchor.constraint(equalTo: segmentedControl.bottomAnchor, constant: 16),
            searchResultsCollecitonView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            searchResultsCollecitonView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            searchResultsCollecitonView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -16)
        ])
    }
    
}

extension MainViewController: UICollectionViewDelegate {
    
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
        cell.configure(with: movie.posterPath ?? "")
        return cell
    }
    
    
}
