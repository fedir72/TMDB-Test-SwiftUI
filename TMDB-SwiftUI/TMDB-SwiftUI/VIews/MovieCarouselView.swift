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
                NavigationLink( destination: MovieDetailView(movie: movie) ) {
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

struct MovieCardView: View {

    let movie: Movie
    let type: CardType
    
    // Вычисляемые свойства для ширины и высоты
    private var cardWidth: CGFloat {
        switch type {
        case .poster: return 200
        case .backdrop: return 300
        }
    }
    
    private var cardHeight: CGFloat {
        switch type {
        case .poster: return 300
        case .backdrop: return 169
        }
    }
    
    var body: some View {
        switch type {
        case .poster:
            WebImage(url: movie.posterURL)
                .resizable()
                .scaledToFill()
                .frame(width: cardWidth, height: cardHeight)
                .clipShape(RoundedRectangle(cornerRadius: 8))
                .shadow(radius: 3)
            
        case .backdrop:
            VStack(alignment: .leading, spacing: 4) {
                WebImage(url: movie.backdropURL)
                    .resizable()
                    .scaledToFill()
                    .frame(width: cardWidth, height: cardHeight)
                    .clipShape(RoundedRectangle(cornerRadius: 8))
                    .shadow(radius: 3)
                
                Text(movie.originalTitle)
                    .font(.caption)
                    .lineLimit(1)
                    .minimumScaleFactor(0.5)
            }
            .frame(width: cardWidth)
        }
    }
}






