//
//  CastMember.swift
//  Movve
//
//  Created by Victor Rubenko on 30.05.2022.
//

import Foundation

struct CastMember: Codable {
    let id: Int
    let name: String
    let popularity: Double
    let character: String
    let profilePath: String?
    
    enum CodingKeys: String, CodingKey {
        case id, name, popularity, character
        case profilePath = "profile_path"
    }
}
