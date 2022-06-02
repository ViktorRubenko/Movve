//
//  UserService.swift
//  Movve
//
//  Created by Victor Rubenko on 30.05.2022.
//

import Foundation
import RealmSwift

protocol DataServiceProtocol {
    func addToFavorite(movie: MovieDetails)
    func getFavoriteMovies() -> [FavoriteMovieModel]
    func removeFromFavorites(movieId: Int)
    func isMovieInFavorites(movieId: Int) -> Bool
    
    func addToFavorite(tvShow: TVShowDetails)
    func getFavoriteTVShows() -> [FavoriteTVShowModel]
    func removeFromFavorites(tvShowId: Int)
    func isTVShowInFavorites(tvShowId: Int) -> Bool
    
}

final class RealmDataService {
    
    static let shared = RealmDataService()
    private let realm: Realm
    private var token: NotificationToken!
    
    private init() {
        let configuration = Realm.Configuration(schemaVersion: 1)
        
        do {
            realm = try Realm.init(configuration: configuration, queue: .main)
        } catch {
            fatalError("Error during creating Realm")
        }
    }
    
    private func add<T>(_ object: T) where T: Object {
        try? realm.write({
            realm.add(object)
        })
    }
    
    private func delete<T>(_ object: T) where T: Object {
        try? realm.write({
            realm.delete(object)
        })
    }
    
    private func get<R>(
        fromEntity entity: R.Type,
        sortedByKey sortKey: String?,
        isAscending: Bool
    ) -> Results<R> where R: Object {
        var objects = realm.objects(entity)
        if sortKey != nil {
            objects = objects.sorted(byKeyPath: sortKey!, ascending: isAscending)
        }
        return objects
    }
    
    private func exists<T>(id: Int, ofType: T.Type) -> Bool where T: Object {
        realm.object(ofType: ofType, forPrimaryKey: id) != nil
    }
    
}

extension RealmDataService: DataServiceProtocol {
    func isMovieInFavorites(movieId: Int) -> Bool {
        exists(id: movieId, ofType: FavoriteMovieModel.self)
    }
    
    func isTVShowInFavorites(tvShowId: Int) -> Bool {
        exists(id: tvShowId, ofType: FavoriteTVShowModel.self)
    }
    
    func getFavoriteMovies() -> [FavoriteMovieModel] {
        Array(get(fromEntity: FavoriteMovieModel.self, sortedByKey: nil, isAscending: true))
    }
    
    func removeFromFavorites(movieId id: Int) {
        let objectsToDelete = getFavoriteMovies().filter { $0.id == id }
        objectsToDelete.forEach { delete($0) }
    }
    
    func getFavoriteTVShows() -> [FavoriteTVShowModel] {
        Array(get(fromEntity: FavoriteTVShowModel.self, sortedByKey: nil, isAscending: true))
    }
    
    func removeFromFavorites(tvShowId id: Int) {
        let objectsToDelete = getFavoriteTVShows().filter { $0.id == id }
        objectsToDelete.forEach { delete($0) }
    }
    
    func addToFavorite(movie: MovieDetails) {
        add(FavoriteMovieModel(movie: movie))
    }
    
    func addToFavorite(tvShow: TVShowDetails) {
        add(FavoriteTVShowModel(tvshow: tvShow))
    }
}
