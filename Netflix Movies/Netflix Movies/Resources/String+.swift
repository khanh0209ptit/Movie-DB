//
//  String+.swift
//  Netflix Movies
//
//  Created by Quang Khánh on 03/02/2023.
//

import Foundation

extension String {
    func shorted(to symbols: Int) -> String {
        guard self.count > symbols else {
            return self
        }
        return self.prefix(symbols) + " ..."
    }
}
