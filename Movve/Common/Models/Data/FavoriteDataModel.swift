//
//  FavoriteDataModel.swift
//  Movve
//
//  Created by Victor Rubenko on 02.06.2022.
//

import Foundation
import RealmSwift

enum FavoriteModelSortedKey: String {
    case dateAdded, title, rating
}

enum FavoriteModelKind: String {
    case Movie, TVShow
}

class FavoriteDataModel: Object {
    @objc dynamic var id = 0
    @objc dynamic var title = ""
    @objc dynamic var releaseDate: String? = nil
    @objc dynamic var dateAdded = Date()
    @objc dynamic var posterPath: String? = nil
    @objc dynamic var rating: Double = 0.0
    @objc dynamic var votes: Int = 0
    @objc dynamic var kind: String = FavoriteModelKind.Movie.rawValue
    @objc dynamic var compoundKey = ""
    let genres = List<String>()
    
    var kindEnum: FavoriteModelKind {
        set {
            kind = newValue.rawValue
        }
        get {
            FavoriteModelKind(rawValue: kind)!
        }
    }
    
    
    override class func primaryKey() -> String? {
        return "compoundKey"
    }
    
    convenience init(movie: MovieDetails) {
        self.init()
        self.id = movie.id
        self.title = movie.title
        self.releaseDate = movie.releaseDate
        self.dateAdded = Date()
        self.posterPath = movie.posterPath
        self.rating = movie.voteAverage
        self.votes = movie.voteCount
        self.kindEnum = .Movie
        movie.genres.forEach { self.genres.append($0.name) }
        self.compoundKey = compoundKeyValue()
    }
    
    convenience init(tvShow: TVShowDetails) {
        self.init()
        self.id = tvShow.id
        self.title = tvShow.name
        self.releaseDate = tvShow.firstAirDate
        self.dateAdded = Date()
        self.posterPath = tvShow.posterPath
        self.rating = tvShow.voteAverage
        self.votes = tvShow.voteCount
        self.kindEnum = .TVShow
        tvShow.genres.forEach { self.genres.append($0.name) }
        self.compoundKey = compoundKeyValue()
    }
    
    func compoundKeyValue() -> String {
        return "\(id)\(kind)"
    }
}
