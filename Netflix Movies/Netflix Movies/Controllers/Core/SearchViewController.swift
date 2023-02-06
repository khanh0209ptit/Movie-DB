//
//  SearchViewController.swift
//  Netflix Movies
//
//  Created by Khanh on 25/11/2022.
//

import UIKit

final class SearchViewController: UIViewController{
    
    private var titles = [Title]()
    private var titleRepository = TitleRepository()
    
    private let discoverTable: UITableView = {
        let table = UITableView()
        table.register(TitleTableViewCell.self, forCellReuseIdentifier: TitleTableViewCell.defaultReuseIdentifier)
        return table
    }()
    
    private let searchController: UISearchController = {
        let controller = UISearchController(searchResultsController: SearchResultsViewController())
        controller.searchBar.placeholder = "Search for a Movies or a TV show"
        controller.searchBar.searchBarStyle = .minimal
        return controller
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        configure()
    
    }
    
    private func configure() {
        view.backgroundColor = .systemBackground
        title = "Search Movie of TV"
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationItem.largeTitleDisplayMode = .always
        
        view.addSubview(discoverTable)
        discoverTable.delegate = self
        discoverTable.dataSource = self
        
        navigationItem.searchController = searchController
        navigationController?.navigationBar.tintColor = .black
        
        fetchDiscoverMovie()
        
        searchController.searchResultsUpdater = self
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        discoverTable.frame = view.bounds
    }

    private func fetchDiscoverMovie() {
        titleRepository.getData(urlApi: Constants.urlDiscoverMovie) { [weak self] (data, error) in
            guard let self = self else { return }
            if let _ = error {
                return
            }
            if let data = data {
                DispatchQueue.main.async {
                    self.titles = data
                    self.discoverTable.reloadData()
                }
            }
        }
    }
}

extension SearchViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return titles.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: TitleTableViewCell.defaultReuseIdentifier, for: indexPath) as? TitleTableViewCell else {
            return UITableViewCell()
        }
        let title = titles[indexPath.row]
        cell.configuge2(title: TitleViewModel(titleName: title.originalName ?? title.originalTitle ?? "" , posterURL: title.posterPath))
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return CGFloat(PhysicalConstants.heightForRowAtItem)
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        let title = titles[indexPath.row]
        guard let titleName = title.originalTitle ?? title.originalName else {
            return
        }
        titleRepository.getMovie(with: titleName) { [weak self] (data , error) in
            if let videoElement = data {
                DispatchQueue.main.async {
                    let viewController = TitlePreviewViewController()
                    viewController.configure(with: DetailMovieModel(title: titleName, youtubeView: videoElement[indexPath.count], titleOverview: title.overview ?? ""))
                    self?.navigationController?.pushViewController(viewController, animated: true)
                }
            } else {
                print(error?.localizedDescription ?? "Error")
            }
        }
    }
}

extension SearchViewController: UISearchResultsUpdating, SearchResultsViewControllerDelegate {
    
    func updateSearchResults(for searchController: UISearchController) {
        let searchBar = searchController.searchBar
        
        guard let query = searchBar.text,
              !query.trimmingCharacters(in: .whitespaces).isEmpty,
              query.trimmingCharacters(in: .whitespaces).count >= 3,
              let resultController = searchController.searchResultsController as? SearchResultsViewController else { return }
        
        resultController.delegate = self
        
        titleRepository.search(with: query) { [weak self] (data, error) in
            if let _ = error {
                return
            }
            if let data = data {
                DispatchQueue.main.async {
                    resultController.titles = data
                    resultController.collectionView.reloadData()
                }
            }
        }
    }
    
    func searchResultsViewControllerDidTabItem(_ viewModel: DetailMovieModel) {
        DispatchQueue.main.sync { [weak self] in
            let viewController = TitlePreviewViewController()
            viewController.configure(with: viewModel)
            self?.navigationController?.pushViewController(viewController, animated: true)
        }
    }
}

