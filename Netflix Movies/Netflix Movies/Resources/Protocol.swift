//
//  Protocol.swift
//  Netflix Movies
//
//  Created by Quang Khánh on 30/11/2022.
//

import Foundation

protocol CollectionViewTableViewCellDelegate: AnyObject {
    func collectionViewTableViewCellDidTabCell(_ cell: CollectionViewTableViewCell, viewModel: DetailMovieModel)
}
