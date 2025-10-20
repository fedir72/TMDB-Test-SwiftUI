//
//  MovieDetailsModels.swift
//  TMDB-SwiftUI
//
//  Created by ihor fedii on 04.10.25.
//

import Foundation

struct MovieDetail: Codable, Identifiable {
  
    let id: Int
    let adult: Bool?
    let backdropPath: String?
    let belongsToCollection: CollectionInfo?
    let budget: Int?
    let genres: [Genre]?
    let homepage: String?
    let imdbID: String?
    let originCountry: [String]?
    let originalLanguage: String?
    let originalTitle: String?
    let overview: String?
    let popularity: Double?
    let posterPath: String?
    let productionCompanies: [ProductionCompany]?
    let productionCountries: [ProductionCountry]?
    let releaseDate: String?
    let revenue: Int?
    let runtime: Int?
    let spokenLanguages: [SpokenLanguage]?
    let status: String?
    let tagline: String?
    let title: String?
    let video: Bool?
    let voteAverage: Double?
    let voteCount: Int?
    
    enum CodingKeys: String, CodingKey {
        case id, adult, genres, homepage, overview, popularity, title, video
        case backdropPath = "backdrop_path"
        case belongsToCollection = "belongs_to_collection"
        case budget
        case imdbID = "imdb_id"
        case originCountry = "origin_country"
        case originalLanguage = "original_language"
        case originalTitle = "original_title"
        case posterPath = "poster_path"
        case productionCompanies = "production_companies"
        case productionCountries = "production_countries"
        case releaseDate = "release_date"
        case revenue, runtime, status, tagline
        case voteAverage = "vote_average"
        case voteCount = "vote_count"
        case spokenLanguages = "spoken_languages"
    }
  
  var backdropURL: URL? {
      guard let path = backdropPath else { return nil }
      return URL(string: "https://image.tmdb.org/t/p/w780\(path)")
  }
  

  var posterURL: URL? {
      guard let path = posterPath else { return nil }
      return URL(string: "https://image.tmdb.org/t/p/w500\(path)")
  }
  
}

// MARK: - Supporting Models

struct CollectionInfo: Codable {
    let id: Int?
    let name: String?
    let posterPath: String?
    let backdropPath: String?
    
    enum CodingKeys: String, CodingKey {
        case id, name
        case posterPath = "poster_path"
        case backdropPath = "backdrop_path"
    }
}

struct ProductionCompany: Codable {
    let id: Int?
    let logoPath: String?
    let name: String?
    let originCountry: String?
    
    enum CodingKeys: String, CodingKey {
        case id, name
        case logoPath = "logo_path"
        case originCountry = "origin_country"
    }
}

struct ProductionCountry: Codable {
    let iso3166_1: String?
    let name: String?
    
    enum CodingKeys: String, CodingKey {
        case iso3166_1 = "iso_3166_1"
        case name
    }
}

struct SpokenLanguage: Codable {
    let englishName: String?
    let iso639_1: String?
    let name: String?
    
    enum CodingKeys: String, CodingKey {
        case englishName = "english_name"
        case iso639_1 = "iso_639_1"
        case name
    }
}
