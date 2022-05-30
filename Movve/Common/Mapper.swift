//
//  Mapper.swift
//  Movve
//
//  Created by Victor Rubenko on 30.05.2022.
//

import Foundation

final class Mapper {
    static func discoveredMovieToDiscoveredModel(_ movie: DiscoveredMovie) -> DiscoveredModel {
        DiscoveredModel(
            name: movie.title,
            imageURL: movie.posterPath != nil ? Constants.ImagesURL.w500.appendingPathComponent(movie.posterPath!) : nil,
            releaseDate: movie.releaseDate
        )
    }
    
    static func discoveredTVShowToDiscoveredModel(_ tvShow: DiscoveredTVShow) -> DiscoveredModel {
        DiscoveredModel(
            name: tvShow.name,
            imageURL: tvShow.posterPath != nil ? Constants.ImagesURL.w500.appendingPathComponent(tvShow.posterPath!) : nil,
            releaseDate: tvShow.firstAirDate
        )
    }
}
