//
//  HomeInterfaces.swift
//  Movve
//
//  Created by Victor Rubenko on 30.05.2022.
//  Copyright (c) 2022 ___ORGANIZATIONNAME___. All rights reserved.
//
//  This file was generated by the 🐍 VIPER generator
//

import UIKit

enum HomeSectionType {
    case movies, tvShows
}

protocol HomeWireframeInterface: WireframeInterface {
    func navigateToMovieDetails(id: Int)
    func navigateToTVDetails(id: Int)
}

protocol HomeViewInterface: ViewInterface {
    func reloadMovies()
    func reloadTVShows()
}

protocol HomePresenterInterface: PresenterInterface {
    var numberOfMovies: Int { get }
    var numberOfTVShows: Int { get }
    
    var sections: [HomeSectionType] { get }
    
    func movie(at indexPath: IndexPath) -> DiscoveredModel
    func loadMovies()
    
    func tvShow(at indexPath: IndexPath) -> DiscoveredModel
    func loadTVShows()
    
    func itemSelected(at indexPath: IndexPath)
}

protocol HomeInteractorInterface: InteractorInterface {
    func getMovies(completion: @escaping(Result<[DiscoveredMovie], Error>) -> Void)
    func getTVShows(completion: @escaping(Result<[DiscoveredTVShow], Error>) -> Void)
}
