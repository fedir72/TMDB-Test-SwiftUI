//
//  MovieSearchViewModel.swift
//  TMDB-SwiftUI
//
//  Created by ihor fedii on 07.10.25.
//
import SwiftUI
import Moya


final class MovieSearchViewModel: ObservableObject {
  
    //MARK: - properties
    @Published var query = ""
    @Published var movies: [Movie] = []
    @Published var isLoading = false
    @Published var currentPage = 1
    @Published var totalPages = 1
    @Published var totalResults = 0
    
    private let provider = MoyaProvider<MovieAPI>()
    
    // MARK: - Search or load current page
    func searchMovies() {
        guard !query.isEmpty else {
            movies = []
            totalResults = 0
            currentPage = 1
            totalPages = 1
            return
        }
        
        guard currentPage <= totalPages, currentPage > 0, !isLoading else { return }
        isLoading = true
        provider.request(.searchMovie(query: query, page: currentPage)) { [weak self] result in
            guard let self = self else { return }
            DispatchQueue.main.async {
                self.isLoading = false
                switch result {
                  
                case .success(let response):
                    do {
                        let decoded = try JSONDecoder().decode(MovieSearchResponse.self, from: response.data)
                        
                        //MARK: - reload movies
                        self.movies = decoded.results
                        self.totalPages = decoded.totalPages
                        self.totalResults = decoded.totalResults
                    } catch {
                        print("Decode error:", error)
                    }
                  
                case .failure(let error):
                    print("Request error:", error)
                }
            }
        }
    }
    
    // MARK: - Load next page
    func loadNextPage() {
        guard currentPage < totalPages, !isLoading else { return }
        currentPage += 1
        searchMovies()
    }
    
    // MARK: - Load previous page
    func loadPreviousPage() {
        guard currentPage > 1, !isLoading else { return }
        currentPage -= 1
        searchMovies()
    }
    
    // MARK: - Reset search
    func resetSearch() {
        movies = []
        totalResults = 0
        currentPage = 1
        totalPages = 1
        query = ""
    }
}

