//
//  CreditsModels.swift
//  TMDB-SwiftUI
//
//  Created by ihor fedii on 11.10.25.
//

import Foundation

// MARK: - Credits Response
struct CreditsResponse: Codable {
    let id: Int
    let cast: [CastMember]
    let crew: [CrewMember]
}

// MARK: - Cast Member
struct CastMember: Codable, Identifiable {
    let id: Int
    let name: String
    let originalName: String?
    let character: String?
    let profilePath: String?
    let order: Int?

    enum CodingKeys: String, CodingKey {
        case id, name, character, order
        case originalName = "original_name"
        case profilePath = "profile_path"
    }
    
    // URL для изображения профиля
    var profileURL: URL? {
        guard let path = profilePath else { return nil }
        return URL(string: "https://image.tmdb.org/t/p/w185\(path)")
    }
}

// MARK: - Crew Member
struct CrewMember: Codable, Identifiable {
    let id: Int
    let name: String
    let originalName: String?
    let job: String?
    let department: String?
    let profilePath: String?

    enum CodingKeys: String, CodingKey {
        case id, name, job, department
        case originalName = "original_name"
        case profilePath = "profile_path"
    }
    
    // URL для изображения профиля
    var profileURL: URL? {
        guard let path = profilePath else { return nil }
        return URL(string: "https://image.tmdb.org/t/p/w185\(path)")
    }
}
