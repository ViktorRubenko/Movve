//
//  DiscoveredMovie.swift
//  Movve
//
//  Created by Victor Rubenko on 30.05.2022.
//

import Foundation

struct DiscoveredMovie: Codable {
    let id: Int
    let title: String
    let posterPath: String?
    let releaseDate: String

    enum CodingKeys: String, CodingKey {
        case id
        case posterPath = "poster_path"
        case releaseDate = "release_date"
        case title
    }
}
