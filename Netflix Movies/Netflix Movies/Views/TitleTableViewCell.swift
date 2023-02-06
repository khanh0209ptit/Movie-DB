//
//  TitleTableViewCell.swift
//  Netflix Movies
//
//  Created by Quang Khánh on 26/11/2022.
//

import UIKit

final class TitleTableViewCell: UITableViewCell, ReusableView {
    
    private let titlesPosterUIImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let titleLable: UILabel = {
       let lable = UILabel()
        lable.numberOfLines = 2
        lable.tintColor = .systemBackground
        lable.font = .boldSystemFont(ofSize: 18)
        lable.translatesAutoresizingMaskIntoConstraints = false
        return lable
    }()
    
    private let playTitleButton: UIButton = {
       let button = UIButton()
        let image = UIImage(systemName: "play.circle", withConfiguration: UIImage.SymbolConfiguration(pointSize: 30))
        button.setImage(image, for: .normal)
        button.tintColor = .black
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        contentView.addSubview(titlesPosterUIImageView)
        contentView.addSubview(titleLable)
        contentView.addSubview(playTitleButton)
        
        applyConstains()
    }
    
    private func applyConstains() {
        let titlesPosterUIImageViewConstrains = [
            titlesPosterUIImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            titlesPosterUIImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 20),
            titlesPosterUIImageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -20),
            titlesPosterUIImageView.widthAnchor.constraint(equalToConstant: 95)
        ]
        
        let titleLableConstrains = [
            titleLable.leadingAnchor.constraint(equalTo: titlesPosterUIImageView.trailingAnchor, constant: 10),
            titleLable.trailingAnchor.constraint(equalTo: playTitleButton.leadingAnchor, constant: 50),
            titleLable.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
        ]
        
        let playTitleButtonConstrains = [
            playTitleButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            playTitleButton.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
        ]
        
        NSLayoutConstraint.activate(titlesPosterUIImageViewConstrains)
        NSLayoutConstraint.activate(titleLableConstrains)
        NSLayoutConstraint.activate(playTitleButtonConstrains)
    }
    
    func configuge2(title: TitleViewModel) {
        if let logoURL = title.posterURL, let url = URL(string: Constants.urlImage + logoURL) {
                self.titlesPosterUIImageView.loadFrom(from: url)
                self.titleLable.text = title.titleName
            } else { print("Error") }
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
