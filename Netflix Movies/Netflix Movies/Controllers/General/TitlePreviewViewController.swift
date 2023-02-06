//
//  TitlePreviewViewController.swift
//  Netflix Movies
//
//  Created by Quang Khánh on 29/11/2022.
//

import UIKit
import WebKit

final class TitlePreviewViewController: UIViewController {
    
    private let titleLable: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 22, weight: .bold)
        label.numberOfLines = 2
        return label
    }()
    
    private let overviewLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 18, weight: .regular)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 10
        return label
    }()
    
    private let downloadButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = .red
        button.setTitle("Play Movie", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 10
        return button
    }()
    
    private let webView: WKWebView = {
        let webView = WKWebView()
        webView.translatesAutoresizingMaskIntoConstraints = false
        return webView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        navigationController?.navigationBar.backgroundColor = .systemBackground
        view.addSubview(webView)
        view.addSubview(titleLable)
        view.addSubview(overviewLabel)
        view.addSubview(downloadButton)
        configuageConstrains()
    }
    
    func configuageConstrains() {
        let webViewConstrains  = [
            webView.topAnchor.constraint(equalTo: view.topAnchor, constant: 30),
            webView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            webView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            webView.heightAnchor.constraint(equalToConstant: 300),
            
        ]
        
        let titleLableConstrains = [
            titleLable.topAnchor.constraint(equalTo: webView.bottomAnchor, constant: 15),
            titleLable.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 15),
            titleLable.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ]
        
        let overviewLabelConstrains = [
            overviewLabel.topAnchor.constraint(equalTo: titleLable.bottomAnchor, constant: 15),
            overviewLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 15),
            overviewLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor),
        ]
        
        let downloadButtonConstrains = [
            downloadButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            downloadButton.topAnchor.constraint(equalTo: overviewLabel.bottomAnchor, constant: 50),
            downloadButton.widthAnchor.constraint(equalToConstant: 300),
            downloadButton.heightAnchor.constraint(equalToConstant: 50),
        ]
        
        NSLayoutConstraint.activate(webViewConstrains)
        NSLayoutConstraint.activate(titleLableConstrains)
        NSLayoutConstraint.activate(overviewLabelConstrains)
        NSLayoutConstraint.activate(downloadButtonConstrains)
    }
    
    func configure(with model: DetailMovieModel) {
        guard let url = URL(string: "\(Constants.baseYoutube)\(model.youtubeView.id.videoId)") else {
            return
        }
        DispatchQueue.main.async { [weak self] in
            self?.titleLable.text = model.title
            self?.overviewLabel.text = model.titleOverview
            self?.webView.load(URLRequest(url: url))
        }
    }
}
