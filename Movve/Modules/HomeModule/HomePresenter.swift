//
//  HomePresenter.swift
//  Movve
//
//  Created by Victor Rubenko on 30.05.2022.
//  Copyright (c) 2022 ___ORGANIZATIONNAME___. All rights reserved.
//
//  This file was generated by the 🐍 VIPER generator
//

import Foundation

final class HomePresenter {

    // MARK: - Private properties -

    private unowned let view: HomeViewInterface
    private let interactor: HomeInteractorInterface
    private let wireframe: HomeWireframeInterface
    
    private let mapper: MovieDBMapperInterface
    
    private var movies: [DiscoveredMovie] = [] {
        didSet {
            view.reloadMovies()
        }
    }
    
    private var tvShows: [DiscoveredTVShow] = [] {
        didSet {
            view.reloadTVShows()
        }
    }

    // MARK: - Lifecycle -

    init(
        view: HomeViewInterface,
        interactor: HomeInteractorInterface,
        wireframe: HomeWireframeInterface,
        mapper: MovieDBMapperInterface
    ) {
        self.view = view
        self.interactor = interactor
        self.wireframe = wireframe
        self.mapper = mapper
    }
}

// MARK: - Extensions -

extension HomePresenter: HomePresenterInterface {
    var numberOfMovies: Int {
        movies.count
    }
    
    var sections: [HomeSectionType] {
        [.movies, .tvShows]
    }
    
    func movie(at indexPath: IndexPath) -> DiscoveredModel {
        mapper.discoveredMovieToDiscoveredModel(movies[indexPath.row])
    }
    
    func loadMovies() {
        interactor.getMovies { [unowned self] result in
            switch result {
            case .failure(let error):
                wireframe.showAlert(with: "Error", message: error.localizedDescription)
            case .success(let movies):
                self.movies = movies
            }
        }
    }
    
    var numberOfTVShows: Int {
        tvShows.count
    }
    
    func tvShow(at indexPath: IndexPath) -> DiscoveredModel {
        mapper.discoveredTVShowToDiscoveredModel(tvShows[indexPath.row])
    }
    
    func loadTVShows() {
        interactor.getTVShows { [unowned self] result in
            switch result {
            case .failure(let error):
                wireframe.showAlert(with: "Error", message: error.localizedDescription)
            case .success(let tvShows):
                self.tvShows = tvShows
            }
        }
    }
    
    func itemSelected(at indexPath: IndexPath) {
        let sectionType = sections[indexPath.section]
        switch sectionType {
        case .movies:
            wireframe.navigateToMovieDetails(id: movies[indexPath.row].id)
        case .tvShows:
            wireframe.navigateToTVDetails(id: tvShows[indexPath.row].id)
        }
    }
}
