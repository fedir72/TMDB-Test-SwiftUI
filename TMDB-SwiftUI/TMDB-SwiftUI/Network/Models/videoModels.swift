//
//  videoModels.swift
//  TMDB-SwiftUI
//
//  Created by ihor fedii on 11.10.25.
//

import Foundation

import Foundation

// MARK: - Main response model
struct MovieVideosResponse: Codable {
    let id: Int
    let results: [MovieVideo]
}

// MARK: - Individual video model
struct MovieVideo: Codable, Identifiable {
    let id: String
    let iso6391: String
    let iso31661: String
    let name: String
    let key: String
    let site: String
    let size: Int
    let type: String
    let official: Bool
    let publishedAt: String
    
    // MARK: - Coding keys
    enum CodingKeys: String, CodingKey {
        case id
        case iso6391 = "iso_639_1"
        case iso31661 = "iso_3166_1"
        case name, key, site, size, type, official
        case publishedAt = "published_at"
    }
    
    // MARK: - computed properties

    var youtubeURL: URL? {
        guard site.lowercased() == "youtube" else { return nil }
        return URL(string: "https://www.youtube.com/watch?v=\(key)")
    }
    
    //MARK: - thumbnail
    var thumbnailURL: URL? {
        guard site.lowercased() == "youtube" else { return nil }
        return URL(string: "https://img.youtube.com/vi/\(key)/hqdefault.jpg")
    }
}

