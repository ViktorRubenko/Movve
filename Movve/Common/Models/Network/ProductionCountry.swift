//
//  ProductionCountry.swift
//  Movve
//
//  Created by Victor Rubenko on 30.05.2022.
//

import Foundation

struct ProductionCountry: Codable {
    let iso, name: String

    enum CodingKeys: String, CodingKey {
        case iso = "iso_3166_1"
        case name
    }
}
