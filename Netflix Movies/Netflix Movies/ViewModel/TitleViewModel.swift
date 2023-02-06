//
//  TitleViewModel.swift
//  Netflix Movies
//
//  Created by Quang Khánh on 26/11/2022.
//

import Foundation

struct TitleViewModel: Codable {
    let titleName: String?
    let posterURL: String?
    
    enum CodingKeys: String, CodingKey {
        case titleName = "original_name"
        case posterURL = "poster_path"
    }
}
