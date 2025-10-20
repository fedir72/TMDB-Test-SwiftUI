//
//  MovieCarouselViewModel.swift
//  TMDB-SwiftUI
//
//  Created by ihor fedii on 20.10.25.
//

import SwiftUI
import Moya

@MainActor
final class MovieCarouselViewModel: ObservableObject {
    @Published var movies: [Movie] = []
    @Published var isLoading = false
    @Published var errorMessage: String?

    private let provider = MoyaProvider<MovieAPI>(callbackQueue: .main)
    private let category: MovieListCategory

    init(category: MovieListCategory) {
        self.category = category
    }

    /// Loads movies if they haven't been fetched yet
    func loadMoviesIfNeeded() {
        guard movies.isEmpty else { return }
        loadMovies()
    }

    /// Forces reload (useful for pull-to-refresh)
    func reloadMovies() {
        movies.removeAll()
        loadMovies()
    }

    private func loadMovies(page: Int = 1) {
        isLoading = true
        errorMessage = nil

        provider.request(.movieList(category: category, page: page)) { [weak self] result in
            guard let self = self else { return }
            self.isLoading = false

            switch result {
            case .success(let response):
                do {
                    let decoded = try JSONDecoder().decode(MovieResponse.self, from: response.data)
                    self.movies = decoded.results
                } catch {
                    self.errorMessage = "Failed to decode movies."
                }

            case .failure(let error):
                self.errorMessage = error.localizedDescription
            }
        }
    }
}
