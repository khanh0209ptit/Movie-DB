//
//  HomeViewController.swift
//  Netflix Movies
//
//  Created by Khanh on 15/11/2022.
//

import UIKit

enum Sections: Int {
    case TrendingMovies = 0
    case TrendingTv = 1
    case Popular = 2
    case Upcomming = 3
    case TopRaced = 4
}

final class HomeViewController: UIViewController  {

    private let sectionTitles = ["Trending Movies", "Trending TV",  "Popular", "Upcomming Movies", "Top Raced"]
    private let numberOfSelection = 40
    private let numberHeightForRowAt = 200
    private let titleRepository = TitleRepository()
    private var listTitle = [Title]()
    private var titleInfo: Title?
    private let network = APICaller.shared
    private let numberOfRowsInSection = 1
    private var titles = [Title]()
    
    private var ramdomTrendingMovie: Title?
    private var headerView: HeroHeaderUIVIew?
    
    let tableView: UITableView = {
        let tableMovies = UITableView(frame: .zero, style: .grouped)
        tableMovies.register(CollectionViewTableViewCell.self, forCellReuseIdentifier: CollectionViewTableViewCell.defaultReuseIdentifier)
            return tableMovies
        }()
        
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
    }
    
    private func configure() {
        //set CGRect hero header
        headerView = HeroHeaderUIVIew(frame: CGRect(x: 0, y: 0, width: view.bounds.width, height: 500))
        tableView.tableHeaderView = headerView
        tableView.delegate = self
        tableView.dataSource = self
        view.backgroundColor = .systemBackground
        view.addSubview(tableView)
        ramdomUpcomingHeader()
        configureNavbar()
    }

    private func ramdomUpcomingHeader() {
        titleRepository.getData(urlApi: urlSections.getMovies) { [weak self] (data, error) in
            guard let self = self else { return }
            if let _ = error {
                print(error?.localizedDescription ?? "Error")
            }
            if let data = data {
                DispatchQueue.main.async { [weak self] in
                    self?.listTitle = data
                    let selectedTitle = self?.listTitle.randomElement()
                    self?.headerView?.configuge(title: TitleViewModel(titleName: selectedTitle?.originalTitle, posterURL: selectedTitle?.posterPath))
                }
            } else {
                print(error?.localizedDescription ?? "Error")
            }
        }
    }
    
    //navbar
    private func configureNavbar() {
        var image = UIImage(named: "netflixLogo")
        image = image?.withRenderingMode(.alwaysOriginal)
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: image, style: .done, target: self, action: nil)
        
        navigationItem.rightBarButtonItems = [
            UIBarButtonItem(image: UIImage(systemName: "person"), style: .done, target: self, action: nil),
            UIBarButtonItem(image: UIImage(systemName: "play.rectangle"), style: .done, target: self, action: nil)
        ]
        navigationController?.navigationBar.tintColor = .black
    }
    
    
    //layout
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tableView.frame = view.bounds
    }
}

extension HomeViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return sectionTitles.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return numberOfRowsInSection
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CollectionViewTableViewCell.defaultReuseIdentifier, for: indexPath) as? CollectionViewTableViewCell else {
            return UITableViewCell()
        }
        cell.delegate = self
        switch indexPath.section {
        case Sections.TrendingMovies.rawValue:
            titleRepository.getData(urlApi: urlSections.getMovies) { [weak self] (data,error) -> (Void) in
                guard let self = self else { return }
                if let _ = error {
                    return
                }
                if let data = data {
                    DispatchQueue.main.async {
                        self.listTitle = data
                        cell.configuge(with: data)
                    }
                }
            }
        case Sections.TrendingTv.rawValue:
            titleRepository.getData(urlApi: urlSections.getTvs) { [weak self] (data, error) -> (Void) in
                guard let self = self else { return }
                if let _ = error {
                    return
                }
                if let data = data {
                    DispatchQueue.main.async {
                        self.listTitle = data
                        cell.configuge(with: data)
                    }
                }
            }
        case Sections.Popular.rawValue:
            titleRepository.getData(urlApi: urlSections.getPopular) { [weak self] (data, error) -> (Void) in
                guard let self = self else { return }
                if let _ = error {
                    return
                }
                if let data = data {
                    DispatchQueue.main.async {
                        self.listTitle = data
                        cell.configuge(with: data)
                    }
                }
            }
        case Sections.Upcomming.rawValue:
            titleRepository.getData(urlApi: urlSections.getUpcoming) { [weak self] (data, error) -> (Void) in
                guard let self = self else { return }
                if let _ = error {
                    return
                }
                if let data = data {
                    DispatchQueue.main.async {
                        self.listTitle = data
                        cell.configuge(with: data)
                    }
                }
            }
        case Sections.TopRaced.rawValue:
            titleRepository.getData(urlApi: urlSections.getTopRaced) { [weak self] (data, error) -> (Void) in
                guard let self = self else { return }
                if let _ = error {
                    return
                }
                if let data = data {
                    DispatchQueue.main.async {
                        self.listTitle = data
                        cell.configuge(with: data)
                    }
                }
            }
        default:
            return UITableViewCell()
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return sectionTitles[section]
    }
    
    //set header in movie
    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        guard let header = view as? UITableViewHeaderFooterView else { return }
        header.textLabel?.font = .systemFont(ofSize: 18, weight: .bold)
        header.textLabel?.frame = CGRect(x: header.bounds.origin.x + 20, y: header.bounds.origin.y, width: 100, height: header.bounds.height)
        header.textLabel?.textColor = .red
        header.textLabel?.text = header.textLabel?.text?.capitalizeFirstLetter()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return CGFloat(numberHeightForRowAt)
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return CGFloat(numberOfSelection)
    }
}

extension HomeViewController: CollectionViewTableViewCellDelegate {
    func collectionViewTableViewCellDidTabCell(_ cell: CollectionViewTableViewCell, viewModel: DetailMovieModel) {
        DispatchQueue.main.sync { [weak self] in
            let viewController = TitlePreviewViewController()
            viewController.configure(with: viewModel)
            self?.navigationController?.pushViewController(viewController, animated: true)
        }
    }
}
