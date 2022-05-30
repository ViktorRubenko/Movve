//
//  DiscoveredTVShow.swift
//  Movve
//
//  Created by Victor Rubenko on 30.05.2022.
//

import Foundation

struct DiscoveredTVShow: Codable {
    let firstAirDate: String
    let id: Int
    let name: String
    let overview: String
    let popularity: Double
    let posterPath: String?
    let voteAverage: Double
    let voteCount: Int

    enum CodingKeys: String, CodingKey {
        case firstAirDate = "first_air_date"
        case id, name
        case overview, popularity
        case posterPath = "poster_path"
        case voteAverage = "vote_average"
        case voteCount = "vote_count"
    }
}
