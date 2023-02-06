//
//  ViewController.swift
//  Netflix Movies
//
//  Created by Khanh on 15/11/2022.
//

import UIKit

final class MainTabBarViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground        
        setupTabBar()
    }
    
    private func setupTabBar() {
        let viewHome = UINavigationController(rootViewController: HomeViewController())
        let viewUpcoming = UINavigationController(rootViewController: UpcomingViewController())
        let viewSearch = UINavigationController(rootViewController: SearchViewController())
        let viewDownload = UINavigationController(rootViewController: DownloadsViewController())
        
        viewHome.title = "Home"
        viewUpcoming.title = "Coming Soon"
        viewSearch.title = "Top Search"
        viewDownload.title = "Downloads"
        
        viewHome.tabBarItem.image = UIImage(systemName: "house")
        viewUpcoming.tabBarItem.image = UIImage(systemName: "play.circle")
        viewSearch.tabBarItem.image = UIImage(systemName: "magnifyingglass")
        viewDownload.tabBarItem.image = UIImage(systemName: "arrow.down.to.line")
        
        tabBar.tintColor = .label
        setViewControllers([viewHome, viewUpcoming,viewSearch ,viewDownload], animated: true)
    }
}

