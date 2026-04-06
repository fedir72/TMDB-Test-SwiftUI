//
//  MovieDetailView.swift
//  TMDB-SwiftUI
//
//  Created by ihor fedii on 07.10.25.

import SwiftUI
import SafariServices
import SDWebImageSwiftUI

struct MovieDetailView: View {
  
  let movieID: Int
  @StateObject private var viewModel: MovieDetailViewModel
  
  init(movieID: Int) {
    self.movieID = movieID
    _viewModel = StateObject(wrappedValue: MovieDetailViewModel(movieID: movieID))
  }
  
  var body: some View {
    Group {
      if viewModel.isLoading {
        ProgressView("Loading...")
          .frame(maxWidth: .infinity, maxHeight: .infinity)
      } else if let movie = viewModel.movieDetail {
        ScrollView {
          VStack(alignment: .leading, spacing: 10) {
            
            HStack(alignment: .top, spacing: 16) {
              if let posterURL = movie.posterURL {
                WebImage(url: posterURL)
                  .resizable()
                  .scaledToFit()
                  .frame(width: 120, height: 180)
                  .cornerRadius(10)
                  .clipped()
              }
              
              VStack(alignment: .leading, spacing: 2) {
                Text(movie.title ?? "Title N/A")
                  .font(.title2)
                  .bold()
                
                if let rating = movie.voteAverage {
                  StarRatingView(rating: rating)
                  Text("(\(movie.voteCount ?? 0) votes)")
                    .font(.caption)
                    .foregroundColor(.secondary)
                }
                
                if let runtime = movie.runtime {
                  Text("\(runtime) min")
                }
                Text("Release: \(movie.releaseDate ?? "N/A")")
                  .font(.subheadline)
                  .foregroundColor(.secondary)
                if let tagline = movie.tagline {
                  Text(tagline)
                    .font(.subheadline)
                    .italic()
                    .foregroundColor(.secondary)
                }
              }
            }
            
            if let genres = movie.genres, !genres.isEmpty {
              ScrollView(.horizontal, showsIndicators: false) {
                HStack {
                  ForEach(genres) { genre in
                    Text(genre.name)
                      .padding(.horizontal, 8)
                      .padding(.vertical, 4)
                      .background(Color.blue.opacity(0.2))
                      .cornerRadius(8)
                  }
                }
              }
            }
            
            if let overview = movie.overview {
              InfoBlockView(title: "Overview",
                            content: overview )
            }
            
            if let companies = movie.productionCompanies, !companies.isEmpty {
              InfoBlockView(title: "Companies",
                            content: companies.compactMap { $0.name }.joined(separator: ", "))
            }
            
            if let countries = movie.productionCountries, !countries.isEmpty {
              InfoBlockView(title: "Production countries",
                            content: countries.compactMap { $0.name }.joined(separator: ", "))
            }
            if let director = viewModel.crew.first(where: { $0.job?.lowercased() == "director" }) {
              InfoBlockView(title: "Director",
                            content: director.name)
            }
            
            if !viewModel.cast.isEmpty {
              InfoBlockView(title: "Main Cast",
                            content: viewModel.cast.prefix(5).map { $0.name }.joined(separator: ", "))
            }
            videoList()
            Spacer()
          }
        }
        .padding()
      } else if let error = viewModel.errorMessage {
        Text(error)
          .movieTitleStyle()
          .padding()
      } else {
        Text("No data available")
          .foregroundColor(.secondary)
      }
    }
    .navigationBarTitleDisplayMode(.inline)
  }
  
  @ViewBuilder
  func videoList() -> some View {
    if !$viewModel.videos.isEmpty {
      VStack(alignment: .leading, spacing: 8) {
        Text("Videos")
          .movieTitleStyle()
          .padding(.horizontal, 10)
        ForEach(viewModel.videos) { video in
          if let url = video.youtubeURL {
            NavigationLink(destination: SafariWebView(url: url)) {
              VideoItemRow(video: video)
            }
            Divider()
          }
        }
      }
      .padding(.horizontal, -10)
      .padding(.bottom, 10)
    }
  }
}

