//
//  UserService.swift
//  Movve
//
//  Created by Victor Rubenko on 30.05.2022.
//

import Foundation
import RealmSwift

protocol DataServiceInterface {
    func addToFavorite(item: MovieDetails)
    func addToFavorite(item: TVShowDetails)
    func getFavorites() -> [FavoriteDataModel]
    func removeFromFavorites(id: Int, kind: FavoriteModelKind)
    func isInFavorites(id: Int, kind: FavoriteModelKind) -> Bool
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
    
    private func exists<T>(id: String, ofType: T.Type) -> Bool where T: Object {
        realm.object(ofType: ofType, forPrimaryKey: id) != nil
    }
    
}

extension RealmDataService: DataServiceInterface {
    func addToFavorite(item: MovieDetails) {
        add(FavoriteDataModel(movie: item))
    }
    
    func addToFavorite(item: TVShowDetails) {
        add(FavoriteDataModel(tvShow: item))
    }
    
    func isInFavorites(id: Int, kind: FavoriteModelKind) -> Bool {
        let compoundKey = "\(id)\(kind.rawValue)"
        return exists(id: compoundKey, ofType: FavoriteDataModel.self)
    }
    
    func getFavorites() -> [FavoriteDataModel] {
        Array(get(fromEntity: FavoriteDataModel.self, sortedByKey: nil, isAscending: true))
    }
    
    func removeFromFavorites(id: Int, kind: FavoriteModelKind) {
        let compoundKey = "\(id)\(kind.rawValue)"
        let objectsToDelete = getFavorites().filter { $0.compoundKey == compoundKey }
        objectsToDelete.forEach { delete($0) }
    }
}
