//
//  MovieService.swift
//  TMDB-SwiftUI
//
//  Created by ihor fedii on 03.10.25.
//

import Foundation
import Moya
import Foundation
import Moya

//https://api.themoviedb.org/3/search/movie?query={query}&aapi_key=2f3a88e5c9dde5f1837f7134848c4432
//https://api.themoviedb.org/3/search/multi?query={query}&api_key=2f3a88e5c9dde5f1837f7134848c4432
//https://api.themoviedb.org/3/movie/{movie_id}?api_key=2f3a88e5c9dde5f1837f7134848c4432              // info about film by film id
//https://api.themoviedb.org/3/discover/movie?...&api_key=2f3a88e5c9dde5f1837f7134848c4432
//https://api.themoviedb.org/3/movie/{movie_id}/reviews?api_key={2f3a88e5c9dde5f1837f7134848c4432
//https://api.themoviedb.org/3/movie/latest?api_key={API_KEY}                   //last loaded to database film

//https://api.themoviedb.org/3/search/movie?api_key=2f3a88e5c9dde5f1837f7134848c4432&language=en-US&query=matrix&page=1&include_adult=false

//  now_playing, popular, top_rated, upcoming
//  https://api.themoviedb.org/3/movie/upcoming?api_key=2f3a88e5c9dde5f1837f7134848c4432&language=en-US&page=1
// MARK: - Categories of Movie Lists
enum MovieListCategory: String , CaseIterable {
  case nowPlaying = "now_playing"
  case upcoming = "upcoming"
  case topRated = "top_rated"
  case popular = "popular"
  
  func titleText() -> String {
    switch self {
    case .nowPlaying:
      return "Now playing"
    case .upcoming:
      return "Upcoming"
    case .topRated:
      return "Top rated"
    case .popular:
      return "Popular"
    }
  }
}

// MARK: - TMDb API Target
enum MovieAPI {
    /// Universal endpoint for movie lists
    case movieList(category: MovieListCategory, page: Int = 1)
    /// Search movies by query string
    case searchMovie(query: String, page: Int = 1)
    /// Get detailed info about a movie
    case movieDetails(id: Int)
    /// Get cast and crew for a movie
    case credits(id: Int)
    /// Get reviews for a movie
    case reviews(id: Int, page: Int = 1)
    /// Get images (posters, backdrops)
    case images(id: Int)
}

extension MovieAPI: TargetType {
    /// Base URL for TMDb API
    var baseURL: URL {
        return URL(string: "https://api.themoviedb.org/3")!
    }
    
    /// Path for each endpoint
    var path: String {
        switch self {
        case .movieList(let category, _):
            return "/movie/\(category.rawValue)"
        case .searchMovie:
            return "/search/movie"
        case .movieDetails(let id):
            return "/movie/\(id)"
        case .credits(let id):
            return "/movie/\(id)/credits"
        case .reviews(let id, _):
            return "/movie/\(id)/reviews"
        case .images(let id):
            return "/movie/\(id)/images"
        }
    }
    
    var method: Moya.Method {
        return .get
    }
    
    var task: Task {
        var params: [String: Any] = [
            "api_key": APIKeys.tmdb,
            "language": "en-US"
        ]
        
        switch self {
        case .movieList(_, let page):
            params["page"] = page
        case .searchMovie(let query, let page):
            params["query"] = query
            params["page"] = page
            params["include_adult"] = false
        case .reviews(_, let page):
            params["page"] = page
        default:
            break
        }
        
        return .requestParameters(parameters: params, encoding: URLEncoding.default)
    }
    
    /// Headers
    var headers: [String : String]? {
        return ["Content-Type": "application/json"]
    }

    var sampleData: Data {
        return Data()
    }
}

//let movieProvider = MoyaProvider<MovieAPI>(plugins: [
//    NetworkLoggerPlugin(configuration: .init(logOptions: .verbose))
//])

// MARK: - API Key storage
enum APIKeys {
    static let tmdb = "2f3a88e5c9dde5f1837f7134848c4432" // 🔑 Insert your TMDb API key here
}
