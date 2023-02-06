//
//  HeroHeaderUIVIew.swift
//  Netflix Movies
//
//  Created by Khanh on 16/11/2022.
//

import UIKit

final class HeroHeaderUIVIew: UIView {

    private let heroImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "enola-holmes-2")
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        return imageView
    }()
    
    private let playButton: UIButton = {
       let playButton = UIButton()
        playButton.setTitle("Play", for: .normal)
        playButton.titleLabel!.font = UIFont(name: "AppleSDGothicNeo-Thin" , size: 25)
        playButton.layer.borderColor = UIColor.red.cgColor
        playButton.backgroundColor = .red
        playButton.layer.borderWidth = 3
        playButton.setTitleColor(.white, for: .normal)
        playButton.layer.cornerRadius = 5
        playButton.translatesAutoresizingMaskIntoConstraints = false
        return playButton
    }()
    
    private let infoButton: UIButton = {
        let infoButton = UIButton()
        infoButton.setBackgroundImage(UIImage(systemName: "info.circle"), for: .selected)
        infoButton.isSelected = true
        infoButton.tintColor = .darkGray
        infoButton.translatesAutoresizingMaskIntoConstraints = false
        return infoButton
    }()
    
    private let myListButton: UIButton = {
        let myListButton = UIButton()
        myListButton.setBackgroundImage(UIImage(systemName: "plus"), for: .selected)
        myListButton.isSelected = true
        myListButton.tintColor = .darkGray
        myListButton.translatesAutoresizingMaskIntoConstraints = false
        return myListButton
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(heroImageView)
        
        addGradient()
        addSubview(playButton)
        addSubview(infoButton)
        addSubview(myListButton)
        applyContraints()
    }
    
    func applyContraints() {
        let playButtonConstrains = [
            playButton.centerXAnchor.constraint(equalTo: centerXAnchor),
            playButton.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -50),
            playButton.widthAnchor.constraint(equalToConstant: 130),
            playButton.heightAnchor.constraint(equalToConstant: 50)
        ]
        
        let infoButtonConstrains = [
            infoButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -90),
            infoButton.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -55),
            infoButton.widthAnchor.constraint(equalToConstant: 40),
            infoButton.heightAnchor.constraint(equalToConstant: 40)
        ]
        
        let myListButtonConstrains = [
            myListButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 90),
            myListButton.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -55),
            myListButton.widthAnchor.constraint(equalToConstant: 40),
            myListButton.heightAnchor.constraint(equalToConstant: 40)
        ]
        
        NSLayoutConstraint.activate(playButtonConstrains)
        NSLayoutConstraint.activate(infoButtonConstrains)
        NSLayoutConstraint.activate(myListButtonConstrains)
    }
    
    func addGradient() {
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = [
            UIColor.clear.cgColor,
            UIColor.systemBackground.cgColor
        ]
        gradientLayer.frame = bounds
        layer.addSublayer(gradientLayer)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        heroImageView.frame = bounds
    }
    
    required init(coder: NSCoder) {
        fatalError()
    }
    func configuge(title: TitleViewModel) {
        if let logoURL = title.posterURL, let url = URL(string: Constants.urlImage + logoURL) {
            self.heroImageView.loadFrom(from: url)
        }
    }
}
