//
//  TVNetwork.swift
//  Movve
//
//  Created by Victor Rubenko on 30.05.2022.
//

import Foundation

struct TVNetwork: Codable {
    let name: String
    let id: Int
    let logoPath, originCountry: String

    enum CodingKeys: String, CodingKey {
        case name, id
        case logoPath = "logo_path"
        case originCountry = "origin_country"
    }
}
