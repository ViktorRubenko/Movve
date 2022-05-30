//
//  MovieDBService.swift
//  Movve
//
//  Created by Victor Rubenko on 30.05.2022.
//

import Foundation
import Alamofire

protocol MovieDBServiceProcotol {
    func discoverMovies(completion: @escaping (Result<[DiscoveredMovie], Error>) -> Void)
    func getMovieDetails(id: Int, completion: @escaping (Result<Movie, Error>) -> Void)
    func getMovieCredits(id: Int, completion: @escaping (Result<MovieCredits, Error>) -> Void)
}

final class MovieDBService {
    
    static let shared = MovieDBService()
    
    private let apiKey: String
    
    private init() {
        let apiKey = Bundle.main.object(forInfoDictionaryKey: "API_KEY") as? String
        guard let apiKey = apiKey, !apiKey.isEmpty else {
            fatalError("API key doesn't exist")
        }
        self.apiKey = apiKey
    }
}

extension MovieDBService: MovieDBServiceProcotol {
    func discoverMovies(completion: @escaping (Result<[DiscoveredMovie], Error>) -> Void) {
        AF.request(
            Constants.API.discoverMovies,
            method: .get,
            parameters: ["api_key": apiKey],
            encoder: .urlEncodedForm
        )
            .validate()
            .responseDecodable(of: DiscoverMovies.self) { dataResponse in
                print(dataResponse.response?.url)
                switch dataResponse.result {
                case .success(let movies):
                    completion(.success(movies.results))
                case .failure(let error):
                    completion(.failure(error))
                }
            }
    }
    
    func getMovieDetails(id: Int, completion: @escaping (Result<Movie, Error>) -> Void) {
        AF.request(
            Constants.API.movie.appendingPathComponent(String(id)),
            method: .get,
            parameters: ["api_key": apiKey],
            encoder: .urlEncodedForm
        )
            .validate()
            .responseDecodable(of: Movie.self) { dataResponse in
                switch dataResponse.result {
                case .success(let movie):
                    completion(.success(movie))
                case .failure(let error):
                    completion(.failure(error))
                }
            }
    }
    
    func getMovieCredits(id: Int, completion: @escaping (Result<MovieCredits, Error>) -> Void) {
        AF.request(
            Constants.API.movie.appendingPathComponent("\(id)/credits"),
            method: .get,
            parameters: ["api_key": apiKey],
            encoder: .urlEncodedForm
        )
            .validate()
            .responseDecodable(of: MovieCredits.self) { dataResponse in
                switch dataResponse.result {
                case .success(let credits):
                    completion(.success(credits))
                case .failure(let error):
                    completion(.failure(error))
                }
            }
    }
}
