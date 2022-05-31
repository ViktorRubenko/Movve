//
//  Mapper.swift
//  Movve
//
//  Created by Victor Rubenko on 30.05.2022.
//

import Foundation


protocol MovieDBMapperInterface {
    func discoveredMovieToDiscoveredModel(_ movie: DiscoveredMovie) -> DiscoveredModel
    func discoveredTVShowToDiscoveredModel(_ tvShow: DiscoveredTVShow) -> DiscoveredModel
    func movieToMovieDetailsModel(_ movie: Movie) -> MovieDetailsModel
    func castMemberToCastMemberModel(_ castMember: CastMember) -> CastMemberModel
}

final class Mapper {
    
    static let shared = Mapper()
    
    private init() {}
    
    private func movieDBDateToDate(_ string: String) -> Date? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        return dateFormatter.date(from: string)
    }
    
    private func runtimeToDuration(_ runtime: Double) -> String {
        let intRuntime = Int(round(runtime))
        let hours = intRuntime / 60
        let minutes = intRuntime % 60
        
        var duration = ""
        if hours > 0 {
            duration += "\(hours) h "
        }
        if minutes > 0 {
            duration += "\(minutes) min"
        }
        return duration
    }
}

extension Mapper: MovieDBMapperInterface {

    func discoveredMovieToDiscoveredModel(_ movie: DiscoveredMovie) -> DiscoveredModel {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMM d, yyyy"
        let releaseDate: String
        if let date = movieDBDateToDate(movie.releaseDate) {
            releaseDate = dateFormatter.string(from: date)
        } else {
            releaseDate = ""
        }
        return DiscoveredModel(
            name: movie.title,
            imageURL: movie.posterPath != nil ? Constants.ImagesURL.w500.appendingPathComponent(movie.posterPath!) : nil,
            releaseDate: releaseDate
        )
    }
    
    func discoveredTVShowToDiscoveredModel(_ tvShow: DiscoveredTVShow) -> DiscoveredModel {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMM d, yyyy"
        let releaseDate: String
        if let date = movieDBDateToDate(tvShow.firstAirDate) {
            releaseDate = dateFormatter.string(from: date)
        } else {
            releaseDate = ""
        }
        return DiscoveredModel(
            name: tvShow.name,
            imageURL: tvShow.posterPath != nil ? Constants.ImagesURL.w500.appendingPathComponent(tvShow.posterPath!) : nil,
            releaseDate: releaseDate
        )
    }
    
    func movieToMovieDetailsModel(_ movie: Movie) -> MovieDetailsModel {
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy"
        let releaseYear: String
        if let date = movieDBDateToDate(movie.releaseDate) {
            releaseYear = dateFormatter.string(from: date)
        } else {
            releaseYear = ""
        }
        
        let genres: String
        if movie.genres.count > 1 {
            genres = movie.genres[0..<2].compactMap({ $0.name }).joined(separator: ", ")
        } else {
            genres = movie.genres.first?.name ?? ""
        }
        return MovieDetailsModel(
            posterURL: movie.posterPath != nil ? Constants.ImagesURL.w500.appendingPathComponent(movie.posterPath!) : nil,
            title: movie.title,
            releaseYear: releaseYear,
            genres: genres,
            duration: runtimeToDuration(movie.runtime ?? 0.0),
            rating: movie.voteAverage,
            overview: movie.overview
        )
    }
    
    func castMemberToCastMemberModel(_ castMember: CastMember) -> CastMemberModel {
        CastMemberModel(
            name: castMember.name,
            character: castMember.character,
            imageURL: castMember.profilePath != nil ? Constants.ImagesURL.w500.appendingPathComponent(castMember.profilePath!) : nil
        )
    }
}
