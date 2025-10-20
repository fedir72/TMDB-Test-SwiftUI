//
//  MovieSEARCHMODELS.swift
//  TMDB-SwiftUI
//
//  Created by ihor fedii on 07.10.25.
//

import Foundation
import Foundation

// MARK: -MainObject (search)
struct MovieSearchResponse: Codable {
    let page: Int
    let results: [Movie]
    let totalPages: Int
    let totalResults: Int
    
    enum CodingKeys: String, CodingKey {
        case page
        case results
        case totalPages = "total_pages"
        case totalResults = "total_results"
    }
}

struct Genre: Codable , Identifiable {
    let id: Int
    let name: String
}
