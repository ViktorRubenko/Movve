//
//  MovieVideos.swift
//  Movve
//
//  Created by Victor Rubenko on 01.06.2022.
//

import Foundation

struct VideosResponse: Codable {
    let id: Int
    let results: [Video]
}
