//
//  URLCall.swift
//  Netflix Movies
//
//  Created by Quang Khánh on 07/12/2022.
//

import Foundation

enum urlSections {
    static let getMovies = "\(Constants.baseURL)/3/trending/movie/day?api_key=\(APICaller.API_KEY)"
    static let getTvs = "\(Constants.baseURL)/3/trending/tv/day?api_key=\(APICaller.API_KEY)"
    static let getPopular = "\(Constants.baseURL)/3/movie/popular?api_key=\(APICaller.API_KEY)"
    static let getUpcoming = "\(Constants.baseURL)/3/movie/upcoming?api_key=\(APICaller.API_KEY)"
    static let getTopRaced = "\(Constants.baseURL)/3/movie/top_rated?api_key=\(APICaller.API_KEY)"
}
