//
//  MovieSearchViewModel.swift
//  TMDB-SwiftUI
//
//  Created by   Ihor Fedii on 03.04.26.
//

import Foundation
import Moya

@MainActor
class MovieSearchViewModel: ObservableObject {
  
  @Published var query: String = ""
  @Published var movies: [Movie] = []
  @Published var totalResults: Int = 0
  @Published var isLoading: Bool = false
  @Published var errorMessage: String?
  
  @Published var currentPage: Int = 1
  @Published var totalPages: Int = 1
  
  private let provider = MoyaProvider<MovieAPI>()
  
  // MARK: - new search
  func searchMovies() {
    let trimmedQuery = query.trimmingCharacters(in: .whitespacesAndNewlines)
    guard !trimmedQuery.isEmpty else {
      movies = []
      return
    }
    currentPage = 1
    fetchMovies(page: currentPage)
  }
  
  //MARK: - next page
  func nextPage() {
    guard currentPage < totalPages else { return }
    currentPage += 1
    fetchMovies(page: currentPage)
  }
  
  //MARK: - previous page
  func previousPage() {
    guard currentPage > 1 else { return }
    currentPage -= 1
    fetchMovies(page: currentPage)
  }
  
  //MARK: - api request  fetchMovies(page: Int)
  private func fetchMovies(page: Int) {
    let trimmedQuery = query.trimmingCharacters(in: .whitespacesAndNewlines)
    
    isLoading = true
    errorMessage = nil
    
    provider.request(.searchMovie(query: trimmedQuery, page: page)) { result in
      self.isLoading = false
      
      switch result {
      case .success(let response):
        do {
          let decoder = JSONDecoder()
          let movieResponse = try decoder.decode(
            MovieSearchResponse.self,
            from: response.data
          )
          self.totalResults = movieResponse.totalResults
          self.totalPages = movieResponse.totalPages
          //MARK: - override the array of movies
          self.movies = movieResponse.results
          
        } catch {
          self.errorMessage = "Decoding error: \(error)"
          self.movies = []
        }
        
      case .failure(let error):
        self.errorMessage = "Network error: \(error.localizedDescription)"
        self.movies = []
      }
    }
  }
}
