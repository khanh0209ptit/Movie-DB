//
//  YoutubeSearchResults.swift
//  Netflix Movies
//
//  Created by Quang Khánh on 29/11/2022.
//

import Foundation

struct YoutubeSearchResponse: Codable {
    let items: [VideoElement]
}

struct VideoElement: Codable {
    let id: IdVideoElement
}

struct IdVideoElement: Codable {
    let kind: String
    let videoId: String
}
