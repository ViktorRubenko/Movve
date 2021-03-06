//
//  TVShowsResponse.swift
//  Movve
//
//  Created by Victor Rubenko on 30.05.2022.
//

import Foundation

struct TVShowsResponse: Codable {
    let page: Int
    let results: [TVShow]
    let totalPages: Int

    enum CodingKeys: String, CodingKey {
        case page, results
        case totalPages = "total_pages"
    }
}
