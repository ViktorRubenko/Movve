//
//  MovieCredits.swift
//  Movve
//
//  Created by Victor Rubenko on 30.05.2022.
//

import Foundation

struct MovieCredits: Codable {
    let id: Int
    let cast: [CastMember]
}
