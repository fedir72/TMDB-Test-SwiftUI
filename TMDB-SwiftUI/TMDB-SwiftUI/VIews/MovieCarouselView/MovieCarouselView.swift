//
//  ContentView.swift
//  TMDB-SwiftUI
//
//  Created by ihor fedii on 03.10.25.
//

import SwiftUI
import SDWebImageSwiftUI

enum CardType {
    case poster
    case backdrop
}

struct MovieCarouselView: View {
    let category: MovieListCategory
    let cardType: CardType

    @StateObject private var viewModel: MovieCarouselViewModel

    init(category: MovieListCategory, cardType: CardType) {
        self.category = category
        self.cardType = cardType
        _viewModel = StateObject(wrappedValue: MovieCarouselViewModel(category: category))
    }

    var body: some View {
        VStack(spacing: 0) {
            if !viewModel.movies.isEmpty {
                // Карусель фильмов
                VStack(alignment: .leading, spacing: 2) {
                    Text(category.titleText())
                        .font(.title.bold())
                    ScrollView(.horizontal, showsIndicators: false) {
                        LazyHStack(spacing: 8) {
                            ForEach(viewModel.movies, id: \.id) { movie in
                                NavigationLink(destination: MovieDetailView(movieID: movie.id)) {
                                    MovieCardView(movie: movie, type: cardType)
                                }
                            }
                        }
                        .padding(.horizontal, 4)
                    }
                }
            } else if viewModel.isLoading {
                LoadView(text: "Loading...")
            } else if let error = viewModel.errorMessage {
                Text(error)
                    .foregroundColor(.red)
                    .padding()
            }
        }
        .frame(maxWidth: .infinity)
        .padding(2)
        .onAppear {
            viewModel.loadMoviesIfNeeded()
        }
    }
}
