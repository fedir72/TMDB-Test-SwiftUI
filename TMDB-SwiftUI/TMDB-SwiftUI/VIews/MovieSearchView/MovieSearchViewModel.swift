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
    @Published var isLoading: Bool = false
    @Published var errorMessage: String?

    private let provider = MoyaProvider<MovieAPI>()

    // MARK: - Search function
    func searchMovies() {
        let trimmedQuery = query.trimmingCharacters(in: .whitespacesAndNewlines)

        guard !trimmedQuery.isEmpty else {
            movies = []
            return
        }

        isLoading = true
        errorMessage = nil

        provider.request(.searchMovie(query: trimmedQuery, page: 1)) { result in

            self.isLoading = false

            switch result {
            case .success(let response):
                do {
                    let decoder = JSONDecoder()
                    let movieResponse = try decoder.decode(MovieSearchResponse.self,
                                                           from: response.data)
                    self.movies = movieResponse.results
                } catch {
                    print("❌ RAW JSON:",
                          String(data: response.data, encoding: .utf8) ?? "")

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

