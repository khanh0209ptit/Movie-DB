//
//  UpcomingViewController.swift
//  Netflix Movies
//
//  Created by Khanh on 25/11/2022.
//

import UIKit

enum PhysicalConstants {
    static let heightForRowAtItem = 140
}

final class UpcomingViewController: UIViewController {
    
    private var titles = [Title]()
    private var titleRepository = TitleRepository()
    
    private let upcomingTable: UITableView = {
        let table = UITableView()
        table.register(TitleTableViewCell.self, forCellReuseIdentifier: TitleTableViewCell.defaultReuseIdentifier)
        return table
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        title = "Upcoming"
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationItem.largeTitleDisplayMode = .always
        
        view.addSubview(upcomingTable)
        upcomingTable.delegate = self
        upcomingTable.dataSource = self
        
        fetchUpcoming()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        upcomingTable.frame = view.bounds
    }
    
    private func fetchUpcoming() {
        titleRepository.getData(urlApi: "\(Constants.baseURL)/3/trending/movie/day?api_key=\(APICaller.API_KEY)") { [weak self] (data, error) in
            guard let self = self else { return }
            if let _ = error {
                return
            }
            if let data = data {
                DispatchQueue.main.async {
                    self.titles = data
                    self.upcomingTable.reloadData()
                }
            }
        }
    }
}

extension UpcomingViewController: UITableViewDelegate, UITableViewDataSource {
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
                DispatchQueue.main.sync {
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
