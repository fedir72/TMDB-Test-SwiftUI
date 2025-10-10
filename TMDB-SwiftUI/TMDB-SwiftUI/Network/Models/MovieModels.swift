//
//  MovieModels.swift
//  TMDB-SwiftUI
//
//  Created by ihor fedii on 04.10.25.
//

import Foundation

import Foundation

// MARK: - MovieResponse
struct MovieResponse: Codable, Identifiable {
    let id = UUID().uuidString
    let dates: Dates?
    let page: Int
    let results: [Movie]
    let totalPages: Int
    let totalResults: Int

    enum CodingKeys: String, CodingKey {
        case dates, page, results
        case totalPages = "total_pages"
        case totalResults = "total_results"
    }
}

// MARK: - Dates
struct Dates: Codable {
    let maximum: String
    let minimum: String
}

// MARK: - Movie
struct Movie: Codable , Identifiable , Equatable {
    let adult: Bool
    let backdropPath: String?        // optional, может быть null
    let genreIDs: [Int]
    let id: Int
    let originalLanguage: String?    // optional
    let originalTitle: String
    let overview: String?
    let popularity: Double?
    let posterPath: String?          // optional, может быть null
    let releaseDate: String?
    let title: String
    let video: Bool?
    let voteAverage: Double?
    let voteCount: Int?

    enum CodingKeys: String, CodingKey {
        case adult
        case backdropPath = "backdrop_path"
        case genreIDs = "genre_ids"
        case id
        case originalLanguage = "original_language"
        case originalTitle = "original_title"
        case overview, popularity
        case posterPath = "poster_path"
        case releaseDate = "release_date"
        case title, video
        case voteAverage = "vote_average"
        case voteCount = "vote_count"
    }
  
  //Equatable
  static func == (lhs: Movie, rhs: Movie) -> Bool {
      lhs.id == rhs.id
  }
}

extension Movie {
    var posterURL: URL? {
        guard let path = posterPath else { return nil }
        return URL(string: "https://image.tmdb.org/t/p/w185\(path)")
    }
    
    var backdropURL: URL? {
        guard let path = backdropPath else { return nil }
        return URL(string: "https://image.tmdb.org/t/p/w300\(path)")
    }
}
