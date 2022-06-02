//
//  FavoriteMovie.swift
//  Movve
//
//  Created by Victor Rubenko on 02.06.2022.
//

import Foundation
import RealmSwift

class FavoriteMovieModel: Object {
    @objc dynamic var id = 0
    @objc dynamic var title = ""
    @objc dynamic var releaseDate = ""
    @objc dynamic var dateAdded = Date()
    @objc dynamic var posterPath: String? = nil
    @objc dynamic var rating: Double = 0.0
    
    override class func primaryKey() -> String? {
        return "id"
    }
    
    convenience init(movie: MovieDetails) {
        self.init()
        self.id = movie.id
        self.title = movie.title
        self.releaseDate = movie.releaseDate
        self.dateAdded = Date()
        self.posterPath = movie.posterPath
        self.rating = movie.voteAverage
    }
}

class FavoriteTVShowModel: Object {
    @objc dynamic var id = 0
    @objc dynamic var title = ""
    @objc dynamic var releaseDate = ""
    @objc dynamic var dateAdded = Date()
    @objc dynamic var posterPath: String? = nil
    @objc dynamic var rating: Double = 0.0
    
    override class func primaryKey() -> String? {
        return "id"
    }
    
    convenience init(tvshow: TVShowDetails) {
        self.init()
        self.id = tvshow.id
        self.title = tvshow.name
        self.releaseDate = tvshow.firstAirDate
        self.dateAdded = Date()
        self.posterPath = tvshow.posterPath
        self.rating = tvshow.voteAverage
    }
}
