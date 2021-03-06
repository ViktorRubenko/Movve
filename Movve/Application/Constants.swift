//
//  Constants.swift
//  Movve
//
//  Created by Victor Rubenko on 30.05.2022.
//

import Foundation

enum Constants {
    enum API {
        static let base = URL(string: "https://api.themoviedb.org/3")!
        static let movie = base.appendingPathComponent("/movie")
        static let tvshow = base.appendingPathComponent("/tv")
        static let discoverMovies = base.appendingPathComponent("/discover/movie")
        static let discoverTVShows = base.appendingPathComponent("/discover/tv")
        static let searchMovies = base.appendingPathComponent("/search/movie")
        static let searchTVShows = base.appendingPathComponent("/search/tv")
    }
    
    enum ImagesURL {
        static let base = URL(string: "https://image.tmdb.org/t/p")!
        static let original = base.appendingPathComponent("/original")
        static let w300 = base.appendingPathComponent("/w300")
        static let w500 = base.appendingPathComponent("/w500")
        static let w780 = base.appendingPathComponent("/w780")
    }
    
    enum YouTube {
        static let embed = URL(string: "https://youtube.com/embed")!
    }
}
