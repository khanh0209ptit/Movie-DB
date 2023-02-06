//
//  DownloadsViewController.swift
//  Netflix Movies
//
//  Created by Khanh on 25/11/2022.
//

import UIKit

final class DownloadsViewController: UIViewController {
    
    private var titles = [TitleItem]()
    private var titleRepository = TitleRepository()
    private let tableView: UITableView = {
        let table = UITableView()
        table.register(TitleTableViewCell.self, forCellReuseIdentifier: TitleTableViewCell.defaultReuseIdentifier)
        return table
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Downloads"
        view.addSubview(tableView)
        view.backgroundColor = .systemBackground
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationItem.largeTitleDisplayMode = .always
        tableView.delegate = self
        tableView.dataSource = self
        featchLocalStorageForDownload()
        NotificationCenter.default.addObserver(
            forName: NSNotification.Name("Downloaded"),
            object: nil, queue: nil) { _ in
            self.featchLocalStorageForDownload()
        }
        
    }
    
    private func featchLocalStorageForDownload() {
        DataPersistenceManager.shared.fetchingTitlesFromDataBase { [weak self] result in
            switch result {
            case .success(let titles):
                self?.titles = titles
                DispatchQueue.main.async {
                    self?.tableView.reloadData()
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tableView.frame = view.bounds
    }
}

extension DownloadsViewController: UITableViewDelegate, UITableViewDataSource {
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
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        switch editingStyle {
        case .delete:
            DataPersistenceManager.shared.deleteTitleWith(model: titles[indexPath.row]) { [weak self] result in
                switch result {
                case .success():
                    self?.showToast(message: "Delete successfully!")
                case .failure(let error):
                    print(error.localizedDescription)
                }
                self?.titles.remove(at: indexPath.row)
                tableView.deleteRows(at: [indexPath], with: .fade)
            }
        default:
            break;
        }
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
