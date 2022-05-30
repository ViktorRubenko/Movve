//
//  Movie.swift
//  Movve
//
//  Created by Victor Rubenko on 30.05.2022.
//

import Foundation

struct Movie: Codable {
    let id: Int
    let genres: [Genre]
    let title: String
    let releaseDate: String
    let voteAverage: Double
    let overview: String
    
    enum CodingKeys: String, CodingKey {
        case id, genres, title, overview
        case releaseDate = "release_date"
        case voteAverage = "vote_average"
    }
}
