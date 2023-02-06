//
//  TitleCollectionViewCell.swift
//  Netflix Movies
//
//  Created by Khanh on 18/11/2022.
//

import UIKit

final class TitleCollectionViewCell: UICollectionViewCell, ReusableView {
    
    private let network = APICaller.shared
    
    private let posterImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.addSubview(posterImageView)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        posterImageView.frame = contentView.bounds
    }
    
    func configuge(title: Title) {
        if let logoURL = title.posterPath, let url = URL(string: Constants.urlImage + logoURL) {
            self.posterImageView.loadFrom(from: url)
        }
    }
}
