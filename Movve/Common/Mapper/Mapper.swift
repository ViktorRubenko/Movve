//
//  Mapper.swift
//  Movve
//
//  Created by Victor Rubenko on 30.05.2022.
//

import Foundation


protocol MovieDBMapperInterface {
    func movieToItemModel(_ movie: Movie) -> ItemModel
    func tvShowToItemModel(_ tvShow: TVShow) -> ItemModel
    func movieToMovieDetailsModel(_ movie: MovieDetails) -> MovieDetailsModel
    func castMemberToCastMemberModel(_ castMember: CastMember) -> CastMemberModel
    func tvShowToTVShowDetailsModel(_ tvShow: TVShowDetails) -> TVShowDetailsModel
    func favoriteDataModelToFavoriteModel(_ dataModel: FavoriteDataModel) -> FavoriteModel
}

final class Mapper {
    
    static let shared = Mapper()
    
    private init() {}
    
    private func movieDBDateToDate(_ string: String?) -> Date? {
        guard let string = string else {
            return nil
        }
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        return dateFormatter.date(from: string)
    }
    
    private func releaseYearFromDBDate(_ string: String?) -> String? {
        guard let string = string else {
            return nil
        }

        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy"
        let releaseYear: String?
        if let date = movieDBDateToDate(string) {
            releaseYear = dateFormatter.string(from: date)
        } else {
            releaseYear = nil
        }
        return releaseYear
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

    func movieToItemModel(_ movie: Movie) -> ItemModel {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMM d, yyyy"
        let releaseDate: String
        if let movieDate = movie.releaseDate, let date = movieDBDateToDate(movieDate) {
            releaseDate = dateFormatter.string(from: date)
        } else {
            releaseDate = ""
        }
        return ItemModel(
            id: movie.id,
            name: movie.title,
            imageURL: movie.posterPath != nil ? Constants.ImagesURL.w500.appendingPathComponent(movie.posterPath!) : nil,
            releaseDate: releaseDate
        )
    }
    
    func tvShowToItemModel(_ tvShow: TVShow) -> ItemModel {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMM d, yyyy"
        let releaseDate: String
        if let tvShowDate = tvShow.firstAirDate, let date = movieDBDateToDate(tvShowDate) {
            releaseDate = dateFormatter.string(from: date)
        } else {
            releaseDate = ""
        }
        return ItemModel(
            id: tvShow.id,
            name: tvShow.name,
            imageURL: tvShow.posterPath != nil ? Constants.ImagesURL.w500.appendingPathComponent(tvShow.posterPath!) : nil,
            releaseDate: releaseDate
        )
    }
    
    func movieToMovieDetailsModel(_ movie: MovieDetails) -> MovieDetailsModel {
        
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
            posterURL: movie.posterPath != nil ? Constants.ImagesURL.w780.appendingPathComponent(movie.posterPath!) : nil,
            title: movie.title,
            releaseYear: releaseYear,
            genres: genres,
            duration: runtimeToDuration(movie.runtime ?? 0.0),
            rating: movie.voteAverage,
            overview: movie.overview,
            homepage: URL(string: movie.homepage ?? "")
        )
    }
    
    func castMemberToCastMemberModel(_ castMember: CastMember) -> CastMemberModel {
        CastMemberModel(
            name: castMember.name,
            character: castMember.character,
            imageURL: castMember.profilePath != nil ? Constants.ImagesURL.w500.appendingPathComponent(castMember.profilePath!) : nil
        )
    }
    
    func tvShowToTVShowDetailsModel(_ tvShow: TVShowDetails) -> TVShowDetailsModel {
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy"
        let releaseYear: String
        if let date = movieDBDateToDate(tvShow.firstAirDate) {
            releaseYear = dateFormatter.string(from: date)
        } else {
            releaseYear = ""
        }
        
        let genres: String
        if tvShow.genres.count > 1 {
            genres = tvShow.genres[0..<2].compactMap({ $0.name }).joined(separator: ", ")
        } else {
            genres = tvShow.genres.first?.name ?? ""
        }
        
        return TVShowDetailsModel(
            posterURL: tvShow.posterPath != nil ? Constants.ImagesURL.w780.appendingPathComponent(tvShow.posterPath!) : nil,
            title: tvShow.name,
            releaseYear: releaseYear,
            genres: genres,
            duration: "\(tvShow.numberOfSeasons) season\(tvShow.numberOfSeasons > 1 ? "s" : "")",
            rating: tvShow.voteAverage,
            overview: tvShow.overview,
            homepage: URL(string: tvShow.homepage ?? "")
        )
    }
    
    func favoriteDataModelToFavoriteModel(_ dataModel: FavoriteDataModel) -> FavoriteModel {
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd.MM.yyyy"
        let date = dateFormatter.string(from: dataModel.dateAdded)
        
        return FavoriteModel(
            id: dataModel.id,
            title: dataModel.title,
            releaseYear: releaseYearFromDBDate(dataModel.releaseDate),
            rating: dataModel.rating,
            posterURL: dataModel.posterPath != nil ? Constants.ImagesURL.w300.appendingPathComponent(dataModel.posterPath!) : nil,
            votes: dataModel.votes,
            genres: dataModel.genres.joined(separator: ", "),
            dateAdded: date
        )
    }
}
