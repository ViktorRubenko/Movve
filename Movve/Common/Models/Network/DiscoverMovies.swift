//
//  DiscoverMovies.swift
//  Movve
//
//  Created by Victor Rubenko on 30.05.2022.
//

import Foundation

struct DiscoverMovies: Codable {
    let page: Int
    let results: [DiscoveredMovie]
    let totalPages: Int
    
    enum CodingKeys: String, CodingKey {
        case page, results
        case totalPages = "total_pages"
    }
}
