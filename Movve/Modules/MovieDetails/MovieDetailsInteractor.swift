//
//  MovieDetailsInteractor.swift
//  Movve
//
//  Created by Victor Rubenko on 30.05.2022.
//  Copyright (c) 2022 ___ORGANIZATIONNAME___. All rights reserved.
//
//  This file was generated by the 🐍 VIPER generator
//

import Foundation
import CloudKit

final class MovieDetailsInteractor {
    private let movieDBService: MovieDBService
    
    init(movieDBService: MovieDBService = .shared) {
        self.movieDBService = movieDBService
    }
}

// MARK: - Extensions -

extension MovieDetailsInteractor: MovieDetailsInteractorInterface {
    
    func getMovieDetails(id movieId: Int, completion: @escaping (Result<Movie, Error>) -> Void)  {
        movieDBService.getMovieDetails(id: movieId, completion: completion)
    }
    
    func getCast(id movieId: Int, completion: @escaping (Result<Credits, Error>) -> Void) {
        movieDBService.getCredits(id: movieId, completion: completion)
    }
    
    func getVideos(id movieId: Int, completion: @escaping (Result<[Video], Error>) -> Void) {
        movieDBService.getMovieVideos(id: movieId, completion: completion)
    }
    
}
