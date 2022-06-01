//
//  Movie.swift
//  Movve
//
//  Created by Victor Rubenko on 30.05.2022.
//

import Foundation

struct Movie: Codable {
    let adult: Bool
    let id: Int
    let overview: String
    let popularity: Double
    let posterPath: String?
    let releaseDate, title: String
    let video: Bool
    let voteAverage: Double
    let voteCount: Int
    
    enum CodingKeys: String, CodingKey {
        case adult
        case id
        case overview, popularity
        case posterPath = "poster_path"
        case releaseDate = "release_date"
        case title, video
        case voteAverage = "vote_average"
        case voteCount = "vote_count"
    }
}
