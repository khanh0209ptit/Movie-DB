//
//  RepositoryType.swift
//  Netflix Movies
//
//  Created by Khanh on 23/11/2022.
//

import Foundation

protocol RepositoryType {
    associatedtype T
    associatedtype V
    
    func getData(urlApi: String, completion: @escaping ([T]?, Error?) -> Void)
    func search(with query: String, completion: @escaping ([T]?, Error?) -> Void)
    func getMovie(with query: String, completion: @escaping([V]?, Error?) -> Void)
}
