//
//  Extension.swift
//  Netflix Movies
//
//  Created by Khanh on 18/11/2022.
//

import Foundation

extension String {
    func capitalizeFirstLetter() -> String {
        return self.prefix(1).uppercased() + self.lowercased().dropFirst()
    }
}
