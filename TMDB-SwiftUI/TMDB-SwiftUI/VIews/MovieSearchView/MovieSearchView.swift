//
//  MovieSearchView.swift
//  TMDB-SwiftUI
//
//  Created by ihor fedii on 06.10.25.
//
import SwiftUI

struct MovieSearchView: View {
  
  //MARK: - properties
  @StateObject private var viewModel = MovieSearchViewModel()
  @State private var showLoadMoreButton = false
  @State private var showLoadPreviousButton = false
  @State private var isLoadingNext = false
  @State private var isLoadingPrevious = false
  
  var body: some View {
    
    NavigationStack {
      VStack {
        //MARK: - Searchbar
        searchBar(query: $viewModel.query) {
          viewModel.searchMovies()
          showLoadMoreButton = false
          showLoadPreviousButton = false
        }
        
        //MARK: - infoAboutResults()
        infoAboutResults()
        ScrollViewReader { proxy in
          ScrollView {
            LazyVStack(spacing: 16) {
              //MARK: - downtoad previous page button
              if viewModel.currentPage > 1 && showLoadPreviousButton {
                loadButton(title: "Previous movies",
                           systemImage: "arrow.up",
                           color: .gray ) {
                  viewModel.loadPreviousPage()
                }
              }
              //MARK: - films list
              ForEach(viewModel.movies, id: \.id) { movie in
                NavigationLink(destination: MovieDetailView(movie: movie)) {
                  MovieRowView(movie: movie)
                    .onAppear {
                      if movie.id == viewModel.movies.last?.id {
                        withAnimation(.easeIn) { showLoadMoreButton = true }
                      }
                      if movie.id == viewModel.movies.first?.id && viewModel.currentPage > 1 {
                        withAnimation(.easeIn) { showLoadPreviousButton = true }
                      }
                    }
                }
              }
              
              //MARK: - download next page button
              if showLoadMoreButton && viewModel.currentPage < viewModel.totalPages {
                loadButton(
                  title: "Show next movies",
                  systemImage: "arrow.down",
                  color: .blue
                ) {
                  viewModel.loadNextPage()
                  //MARK: scroll to first element of list
                  if let firstMovieID = viewModel.movies.first?.id {
                    withAnimation(.easeIn) { proxy.scrollTo(firstMovieID, anchor: .top) }
                  }
                }
              }
              
              //MARK: - download indicator
              if viewModel.isLoading {
                ProgressView()
                  .padding()
              }
            }
            .padding(.horizontal)
          }
        }
      }
      .navigationTitle("Movie Search")
    }
  }
}

  
  
fileprivate extension MovieSearchView {
  
  //MARK: - UI functions
  @ViewBuilder
  func searchBar(query: Binding<String>,
                 onSearch: @escaping () -> Void) -> some View {
    HStack {
      TextField("Enter movie title...", text: query)
        .padding(.horizontal, 16)
        .padding(.vertical, 10)
        .background(Color(.systemGray5))
        .clipShape(Capsule())
      Button(action: onSearch) {
        Image(systemName: "magnifyingglass")
          .font(.title2)
          .foregroundColor(.white)
          .padding(10)
          .background(Color.blue)
          .clipShape(Circle())
          .shadow(radius: 2)
      }
    }
    .padding()
  }
  
  @ViewBuilder
  func infoAboutResults() -> some View {
    if !viewModel.movies.isEmpty {
      HStack {
        Text("""
           Found \(viewModel.totalResults) movies.
           Page \(viewModel.currentPage) of \(viewModel.totalPages)
           """)
        .font(.subheadline)
        .foregroundColor(.primary)
        .padding(.horizontal)
        Spacer()
      }
      .padding(.vertical, 15)
    }
  }
  
  func loadButton(
    title: String,
    systemImage: String,
    color: Color,
    isRotating: Bool = false,
    action: @escaping () -> Void
  ) -> some View {
    Button(action: action) {
      Label {
        Text(title)
          .bold()
      } icon: {
        Image(systemName: systemImage)
          .rotationEffect(.degrees(isRotating ? 360 : 0))
          .animation(
            isRotating ?
              .linear(duration: 0.6).repeatForever(autoreverses: false)
            : .default,
            value: isRotating
          )
      }
      .font(.headline)
      .foregroundColor(.white)
      .padding(.vertical, 14)
      .frame(maxWidth: .infinity)
      .background(
        LinearGradient(gradient: Gradient(colors: [color.opacity(0.8), color]),
                       startPoint: .topLeading,
                       endPoint: .bottomTrailing)
      )
      .clipShape(Capsule())
      .shadow(radius: 4)
      .padding(.horizontal, 16)
    }
    .padding(.vertical, 8)
  }
  
}
  
