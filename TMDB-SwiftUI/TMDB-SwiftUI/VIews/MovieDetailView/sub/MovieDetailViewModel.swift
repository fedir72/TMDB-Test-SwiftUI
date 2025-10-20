//
//  MovieDetailViewModel.swift
//  TMDB-SwiftUI
//
//  Created by ihor fedii on 11.10.25.

import Foundation
import SwiftUI
import Moya

@MainActor
final class MovieDetailViewModel: ObservableObject {

    // MARK: - Published properties
    @Published var movieDetail: MovieDetail?
    @Published var videos: [MovieVideo] = []
    @Published var cast: [CastMember] = []
    @Published var crew: [CrewMember] = []
    @Published var isLoading = false
    @Published var errorMessage: String?
  
    // MARK: - Private properties
    private let provider: MoyaProvider<MovieAPI>
    private let movieID: Int

    // MARK: - Init
    init(movieID: Int) {
        // Все ответы Moya теперь приходят в главный поток
        self.provider = MoyaProvider<MovieAPI>(callbackQueue: .main)
        self.movieID = movieID
        loadDetails()
    }

    // MARK: - Load all details
    func loadDetails() {
        isLoading = true
        errorMessage = nil
        let group = DispatchGroup()

        // MARK: - Download movie details
        group.enter()
        provider.request(.movieDetails(id: movieID)) { [weak self] result in
            defer { group.leave() }
            guard let self = self else { return }

            switch result {
            case .success(let response):
                do {
                    let decoded = try JSONDecoder().decode(MovieDetail.self, from: response.data)
                    self.movieDetail = decoded
                } catch {
                    self.errorMessage = "Failed to decode movie details"
                }

            case .failure(let error):
                self.errorMessage = error.localizedDescription
            }
        }

        // MARK: - Download videos
        group.enter()
        provider.request(.videos(id: movieID)) { [weak self] result in
            defer { group.leave() }
            guard let self = self else { return }

            switch result {
            case .success(let response):
                do {
                    let decoded = try JSONDecoder().decode(MovieVideosResponse.self, from: response.data)
                    self.videos = decoded.results
                } catch {
                    self.errorMessage = "Failed to decode videos"
                }

            case .failure(let error):
                self.errorMessage = error.localizedDescription
            }
        }

        // MARK: - Download actors and crew
        group.enter()
        provider.request(.credits(id: movieID)) { [weak self] result in
            defer { group.leave() }
            guard let self = self else { return }

            switch result {
            case .success(let response):
                do {
                    let decoded = try JSONDecoder().decode(CreditsResponse.self, from: response.data)
                    self.cast = decoded.cast
                    self.crew = decoded.crew
                } catch {
                    self.errorMessage = "Failed to decode cast/crew"
                }

            case .failure(let error):
                self.errorMessage = error.localizedDescription
            }
        }

        // MARK: - All requests finished
        group.notify(queue: .main) {
            self.isLoading = false
        }
    }
}

