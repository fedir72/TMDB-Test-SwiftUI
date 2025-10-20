//
//  ContentView.swift
//  TMDB-SwiftUI
//
//  Created by ihor fedii on 03.10.25.
//

import SwiftUI
import Moya
import SDWebImageSwiftUI

enum CardType {
    case poster
    case backdrop
}

struct MovieCarouselView: View {
    let category: MovieListCategory
    let cardType: CardType
    let movieProvider = MoyaProvider<MovieAPI>()
    @State var movieresponse: MovieResponse?
    
  var body: some View {
    VStack(spacing: 0) {
      if let movieresponse = movieresponse {
        // Карусель фильмов
        VStack(alignment: .leading, spacing: 2) {
          Text(category.titleText())
            .font(.title.bold())
          ScrollView(.horizontal, showsIndicators: false) {
            LazyHStack(spacing: 8) {
              ForEach(movieresponse.results, id: \.id) { movie in
                NavigationLink( destination: MovieDetailView(movieID: movie.id) ) {
                  MovieCardView(movie: movie, type: cardType)
                }
              }
            }
            .padding(.horizontal, 4)
          }
        }
      } else {
        LoadView(text: "Loading...")
      }
    }
    .frame(maxWidth: .infinity)
    .padding(2)
    .onAppear {
      movieProvider.request(.movieList(category: category, page: 1)) { result in
        switch result {
        case .success(let response):
          do {
            let movies = try JSONDecoder().decode(MovieResponse.self, from: response.data)
            self.movieresponse = movies
            print("Loaded \(movies.results.count) movies")
          } catch {
            print("Decoding error:", error)
          }
        case .failure(let error):
          print("error", error)
        }
      }
    }
  }
}


