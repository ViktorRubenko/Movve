//
//  FavoriteModel.swift
//  Movve
//
//  Created by Victor Rubenko on 03.06.2022.
//

import Foundation

struct FavoriteModel {
    let id: Int
    let title: String
    let releaseYear: String?
    let rating: Double
    let posterURL: URL?
    let votes: Int
    let genres: String
    let dateAdded: String
}
