//
//  UITableView+.swift
//  Netflix Movies
//
//  Created by Khanh on 25/11/2022.
//

import UIKit

extension UITableView {
    func register<T: UITableViewCell>(nibName name: T.Type, atBundle bundleClass: AnyClass? = nil) where T: ReusableView {
            let identifier = T.defaultReuseIdentifier
            let nibName = T.nibName
            
            var bundle: Bundle? = nil
            if let bundleName = bundleClass {
                bundle = Bundle(for: bundleName)
            }
            register(UINib(nibName: nibName, bundle: bundle), forCellReuseIdentifier: identifier)
        }
        
        func dequeueReusableCell<T: UITableViewCell>(_ type: T.Type) -> T where T: ReusableView {
            guard let cell =  self.dequeueReusableCell(withIdentifier: T.defaultReuseIdentifier) as? T else {
                fatalError("Could not dequeue cell with identifier: \(T.defaultReuseIdentifier)")
            }
            return cell
    }
}
