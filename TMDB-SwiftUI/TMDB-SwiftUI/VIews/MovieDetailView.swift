//
//  MovieDetailView.swift
//  TMDB-SwiftUI
//
//  Created by ihor fedii on 07.10.25.
//

import SwiftUI

struct MovieDetailView: View {
    let movie: Movie
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 16) {
                
                // Постер фильма
                if let posterPath = movie.posterPath,
                   let url = URL(string: "https://image.tmdb.org/t/p/w500\(posterPath)") {
                    AsyncImage(url: url) { image in
                        image
                            .resizable()
                            .scaledToFit()
                            .cornerRadius(10)
                    } placeholder: {
                        ProgressView()
                    }
                    .frame(maxWidth: .infinity)
                }
                
                // Название и рейтинг
                Text(movie.title)
                    .font(.title)
                    .bold()
                
                HStack {
                    Text("Rating: \(String(format: "%.1f", movie.voteAverage ?? 0 ))")
                    Spacer()
                    Text("Release: \(movie.releaseDate ?? "N/A")")
                }
                .font(.subheadline)
                .foregroundColor(.secondary)
                
                // Описание
                Text(movie.overview ?? "overview not found")
                    .font(.body)
                    .fixedSize(horizontal: false, vertical: true)
                
                Spacer()
            }
            .padding()
        }
        .navigationTitle(movie.title)
        .navigationBarTitleDisplayMode(.inline)
    }
}

//#Preview {
//  MovieDetailView(movie: <#Movie#>)
//}
