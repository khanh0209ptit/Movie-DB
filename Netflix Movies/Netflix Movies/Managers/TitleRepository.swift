//
//  TitleRepository.swift
//  Netflix Movies
//
//  Created by Khanh on 23/11/2022.
//

import Foundation

final class TitleRepository: RepositoryType {
    
    typealias T = Title
    typealias V = VideoElement
    
    // access the singleton
    private let network = APICaller.shared
    
    func getMovie(with query: String, completion: @escaping ([VideoElement]?, Error?) -> Void) {
        guard let query = query.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed) else {
            return
        }
        network.getJSON(urlApi: "\(Constants.youtubeBaseURL)q=\(query)&key=\(APICaller.youtubeAPI)") { (data: YoutubeSearchResponse?, error)  in
                if let data = data {
                    let domain = data.items
                        completion(domain, nil)
                } else { completion(nil, error) }
            }
        }
    
    func search(with query: String, completion: @escaping ([Title]?, Error?) -> Void) {
        guard let query = query.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed) else { return }
        network.getJSON(urlApi: "\(Constants.baseURL)/3/search/movie?api_key=\(APICaller.API_KEY)&query=\(query)") { (data: TitleResponse?, error)  in
            print("data \(String(describing: data?.results.count))")
            if let data = data {
                let domainTitle = data.results
                DispatchQueue.main.async {
                    completion(domainTitle, nil)
                }
            }
        }
    }
    
    func getData(urlApi: String, completion: @escaping ([Title]?, Error?) -> Void) {
        network.getJSON(urlApi: urlApi) { (data: TitleResponse?, error)  in
            var domainTitle = [Title]()
            if let data = data {
                for title in data.results {
                    domainTitle.append(Title(
                        id: title.id,
                        mediaType: title.mediaType,
                        originalName: title.originalName,
                        originalTitle: title.originalTitle,
                        posterPath: title.posterPath,
                        overview: title.overview,
                        vote_count: title.vote_count,
                        releaseDate: title.releaseDate,
                        vote_average: title.vote_average
                    ))
                }
                DispatchQueue.main.async {
                    completion(domainTitle, nil)
                }
            }
        }
    }
}
