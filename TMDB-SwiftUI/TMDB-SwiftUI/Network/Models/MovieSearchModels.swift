//
//  MovieSEARCHMODELS.swift
//  TMDB-SwiftUI
//
//  Created by ihor fedii on 07.10.25.
//

import Foundation
import Foundation

// MARK: - Корневой объект ответа TMDB
struct MovieSearchResponse: Codable {
    let page: Int
    let results: [Movie]
    let totalPages: Int
    let totalResults: Int
    
    // Соответствие ключей JSON с snake_case к camelCase
    enum CodingKeys: String, CodingKey {
        case page
        case results
        case totalPages = "total_pages"
        case totalResults = "total_results"
    }
}

//// MARK: - Модель фильма
//struct Movie: Codable, Identifiable {
//  let id: Int
//  let adult: Bool
//  let title: String
//  let originalTitle: String
//  let overview: String?
//  let posterPath: String?
//  let backdropPath: String?
//  let releaseDate: String?
//  let voteAverage: Double?
//  let voteCount: Int?
//  let popularity: Double?
//  let originalLanguage: String?
//  let video: Bool
//  let genreIDs: [Int]?
//  
//}
    
//    // Для преобразования snake_case в camelCase
//    enum CodingKeys: String, CodingKey {
//        case id
//        case adult
//        case title
//        case originalTitle = "original_title"
//        case overview
//        case posterPath = "poster_path"
//        case backdropPath = "backdrop_path"
//        case releaseDate = "release_date"
//        case voteAverage = "vote_average"
//        case voteCount = "vote_count"
//        case popularity
//        case originalLanguage = "original_language"
//        case video
//        case genreIDs = "genre_ids"
//    }
//    
//    // URL для постера (опционально)
//    var posterURL: URL? {
//        guard let posterPath = posterPath else { return nil }
//        return URL(string: "https://image.tmdb.org/t/p/w500\(posterPath)")
//    }
//    
//    // URL для backdrop (опционально)
//    var backdropURL: URL? {
//        guard let backdropPath = backdropPath else { return nil }
//        return URL(string: "https://image.tmdb.org/t/p/w780\(backdropPath)")
//    }
//}

// MARK: - Модель жанра (если захотим расширять)
struct Genre: Codable {
    let id: Int
    let name: String
}
