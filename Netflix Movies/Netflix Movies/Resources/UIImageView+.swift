//
//  UIView+.swift
//  Netflix Movies
//
//  Created by Khanh on 25/11/2022.
//
import UIKit

extension UIImageView {
    func loadFrom(from url: URL, placeholder: UIImage? = nil) {
        image = placeholder
        ImageManager.shared.fetchImage(url: url) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let image):
                DispatchQueue.main.async {
                    self.image = image
                }
            case .failure(let error):
                print(error)
            }
        }
    }
}
