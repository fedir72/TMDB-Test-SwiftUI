//
//  MovieSearchView.swift
//  TMDB-SwiftUI
//
//  Created by ihor fedii on 06.10.25.
//
import SwiftUI

struct MovieSearchView: View {
  
  @StateObject private var viewModel = MovieSearchViewModel()
  
  var body: some View {
    NavigationStack {
      VStack {
        customSearchBar()
        if let error = viewModel.errorMessage {
            Text(error)
              .foregroundColor(.red)
              .padding(.horizontal)
          
        }
        if !viewModel.movies.isEmpty {
          searchInfoBlock()
        }
        movieListView()
        if viewModel.isLoading {
          ProgressView()
            .padding()
        }
        if !viewModel.movies.isEmpty {
          paginationControlView()
        }
        Spacer()
      }
      .navigationTitle("Movie Search")
    }
  }
}

//MARK: - UI Function

fileprivate extension MovieSearchView {
  
  func searchInfoBlock() -> some View {
    return HStack {
      Text("Found: \(viewModel.totalResults) | Page \(viewModel.currentPage)/\(viewModel.totalPages)")
      Spacer()
    }
    .padding(.horizontal)
    .font(.headline.bold())
    .foregroundStyle(.red)
  }
  
  func customSearchBar() -> some View {
    HStack {
      TextField("Enter movie title...", text: $viewModel.query)
        .autocorrectionDisabled(true)
        .textInputAutocapitalization(.never)
        .textFieldStyle(.roundedBorder)
        .submitLabel(.search)
        .onSubmit {
          viewModel.searchMovies()
        }
      
      Button(action: viewModel.searchMovies) {
        Image(systemName: "magnifyingglass")
          .padding(8)
          .background(Color.blue)
          .foregroundColor(.white)
          .clipShape(Circle())
      }
    }
    .padding()
  }
  
  func movieListView() -> some View {
    ScrollViewReader { scrollProxy in
      ScrollView {
        LazyVStack(spacing: 12) {
          ForEach(viewModel.movies) { movie in
            NavigationLink(destination: MovieDetailView(movieID: movie.id)) {
              SearchMovieRowView(movie: movie)
            }
            .id(movie.id)
          }
        }
        .padding(.horizontal)
      }
      .onChange(of: viewModel.movies) { _ , newValue in
        if let firstMovie = newValue.first {
          withAnimation {
            scrollProxy.scrollTo(firstMovie.id, anchor: .top)
          }
        }
      }
    }
  }
  
  func paginationControlView() -> some View {
    HStack(spacing: 16) {
      Button("Previous") {
        viewModel.previousPage()
      }
      .capsuleButtonShadow()
      .disabled(viewModel.currentPage < 2)
      
      Button("Next") {
        viewModel.nextPage()
      }
      .capsuleButtonShadow()
      .disabled(viewModel.currentPage == viewModel.totalPages)
    }
    .padding(10)
  }
}


#Preview {
  MovieSearchView()
}
