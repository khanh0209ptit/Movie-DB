//
//  UIViewController+.swift
//  Netflix Movies
//
//  Created by Quang Khánh on 09/12/2022.
//

import Foundation
import UIKit

extension UIViewController {
    func showToast(message: String) {
        let toastLabel = UILabel(frame: CGRect(
            x: self.view.frame.width/2-90,
            y: self.view.frame.height/2,
            width: 200, height: 40))
        toastLabel.textAlignment = .center
        toastLabel.textColor = .white
        toastLabel.backgroundColor = UIColor.red.withAlphaComponent(0.6)
        toastLabel.alpha = 1.0
        toastLabel.layer.cornerRadius = 10
        toastLabel.clipsToBounds  = true
        toastLabel.text = message
        self.view.addSubview(toastLabel)
        
        UIView.animate(withDuration: 4.0, delay: 1.0, options: .curveEaseInOut, animations: {
            toastLabel.alpha = 0.0
        }) { (isCompleed) in
            toastLabel.removeFromSuperview()
        }
    }
}
