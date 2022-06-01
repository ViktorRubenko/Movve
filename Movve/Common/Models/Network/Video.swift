//
//  Video.swift
//  Movve
//
//  Created by Victor Rubenko on 01.06.2022.
//

import Foundation

struct Video: Codable {
    let name, key: String
    let site: String
    let size: Int
    let type: String
    let official: Bool
    let publishedAt, id: String

    enum CodingKeys: String, CodingKey {
        case name, key, site, size, type, official
        case publishedAt = "published_at"
        case id
    }
}
