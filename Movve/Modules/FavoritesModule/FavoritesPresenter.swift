//
//  FavoritesPresenter.swift
//  Movve
//
//  Created by Victor Rubenko on 30.05.2022.
//  Copyright (c) 2022 ___ORGANIZATIONNAME___. All rights reserved.
//
//  This file was generated by the 🐍 VIPER generator
//

import Foundation

enum FavoriteSegments: String {
    case Movie, TVShow
}

final class FavoritesPresenter {

    // MARK: - Private properties -

    private unowned let view: FavoritesViewInterface
    private let interactor: FavoritesInteractorInterface
    private let wireframe: FavoritesWireframeInterface
    private var _items = [FavoriteModel]()
    private var currentFavorites: FavoriteSegments = .Movie
    private var _segments: [FavoriteSegments] = [.Movie, .TVShow]

    // MARK: - Lifecycle -

    init(
        view: FavoritesViewInterface,
        interactor: FavoritesInteractorInterface,
        wireframe: FavoritesWireframeInterface
    ) {
        self.view = view
        self.interactor = interactor
        self.wireframe = wireframe
    }
}

// MARK: - Extensions -

extension FavoritesPresenter: FavoritesPresenterInterface {
    var items: [FavoriteModel] {
        _items
    }
    
    var segments: [String] {
        _segments.map { $0.rawValue }
    }
    
    func loadData() {
        switch currentFavorites {
            case .Movie:
                _items = interactor.getFavoriteMovies()
            case .TVShow:
                _items = interactor.getFavoriteTVShows()
        }
        view.reloadData()
    }
    
    func didSelectSegment(index: Int) {
        currentFavorites = _segments[index]
        loadData()
    }
    
    func item(for indexPath: IndexPath) -> FavoriteModel {
        _items[indexPath.row]
    }
    
    func didSelectItem(indexPath: IndexPath) {
        switch currentFavorites {
        case .Movie:
            wireframe.navigateToMovieDetails(movieId: item(for: indexPath).id)
        case .TVShow:
            wireframe.navigateToTVShowDetails(tvShowId: item(for: indexPath).id)
        }
    }
    
    func swapToRemove(indexPath: IndexPath) {
        switch currentFavorites {
        case .Movie:
            interactor.removeFavoriteMovie(id: item(for: indexPath).id)
        case .TVShow:
            interactor.removeFavoriteTVShow(id: item(for: indexPath).id)
        }
        _items.remove(at: indexPath.row)
        view.removeItem(at: indexPath)
    }
}
