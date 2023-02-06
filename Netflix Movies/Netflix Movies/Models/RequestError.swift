//
//  RequestError.swift
//  Netflix Movies
//
//  Created by Khanh on 22/11/2022.
//

import Foundation

enum RequestError: Error {
    case badResponse
    case badStatusCode(Int)
    case badData
}
