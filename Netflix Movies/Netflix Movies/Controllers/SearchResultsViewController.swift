//
//  collectionView.swift
//  Netflix Movies
//
//  Created by Quang Khánh on 27/11/2022.
//

import UIKit

final class SearchResultsViewController: UIViewController {
    
    var titles: [Title] = [Title]()
    var titleRepository = TitleRepository()
    
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
    public func configuge(with titles: [Title]) {
        self.titles = titles
        DispatchQueue.main.async { [weak self] in
            self?.collectionView.reloadData()
        }
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
        print(cell)
        
        guard titles[indexPath.row].posterPath != nil else {
            return cell
        }
        cell.configuge(title: titles[indexPath.row])
        return cell
    }
}
