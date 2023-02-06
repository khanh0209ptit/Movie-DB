//
//  collectionView.swift
//  Netflix Movies
//
//  Created by Quang Khánh on 27/11/2022.
//

import UIKit

protocol SearchResultsViewControllerDelegate: AnyObject {
    func searchResultsViewControllerDidTabItem(_ viewModel: DetailMovieModel)
}

final class SearchResultsViewController: UIViewController {
    
    public var titles = [Title]()
    private var titleRepository = TitleRepository()
    public weak var delegate: SearchResultsViewControllerDelegate?
    
    var collectionView: UICollectionView! {
        let layout = UICollectionViewFlowLayout()
        let collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: layout)
        collectionView.delegate = self
        collectionView.dataSource = self
        view.addSubview(collectionView)
        collectionView.register(TitleCollectionViewCell.self, forCellWithReuseIdentifier: TitleCollectionViewCell.defaultReuseIdentifier)
        layout.itemSize = CGSize(width: UIScreen.main.bounds.width / 3 - 10, height: 200)
        layout.minimumInteritemSpacing = 0
        return collectionView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        configGUI()
    }
    
    private func configGUI() {
        view.backgroundColor = .systemBackground
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
    }
}

extension SearchResultsViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return titles.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TitleCollectionViewCell.defaultReuseIdentifier, for: indexPath) as? TitleCollectionViewCell else {
            return UICollectionViewCell()
        }
        
        guard titles[indexPath.row].posterPath != nil else {
            return cell
        }
        cell.configuge(title: titles[indexPath.row])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
        
        let title = titles[indexPath.row]
        let titleName = title.originalTitle ?? ""
        titleRepository.getMovie(with: titleName) { [weak self] (data , error) in
            if let videoElement = data {
                self?.delegate?.searchResultsViewControllerDidTabItem(DetailMovieModel(title: title.originalTitle ?? "", youtubeView: videoElement[indexPath.count], titleOverview: title.overview ?? ""))
            } else {
                print(error?.localizedDescription ?? "Error")
            }
        }
    }
}
