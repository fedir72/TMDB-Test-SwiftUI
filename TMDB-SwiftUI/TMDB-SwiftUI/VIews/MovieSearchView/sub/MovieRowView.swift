//
//  MovieRowView.swift
//  TMDB-SwiftUI
//
//  Created by ihor fedii on 07.10.25.
//

import SwiftUI
import SDWebImageSwiftUI

struct MovieRowView: View {
    let movie: Movie
    
  var body: some View {
    HStack(alignment: .top, spacing: 12) {
      // Poster
      if let path = movie.posterPath,
         let url = URL(string: "https://image.tmdb.org/t/p/w200\(path)") {
        WebImage(url: url)
          .resizable()
          .scaledToFill()
          .frame(width: 80, height: 120)
          .cornerRadius(8)
          .clipped()
      } else {
        Image(systemName: "photo.circle.fill")
          .resizable()
          .scaledToFill()
          .frame(width: 80, height: 80)
          .cornerRadius(8)
          .clipped()
          .foregroundColor(.gray.opacity(0.5))
      }
      VStack(alignment: .leading, spacing: 6) {
        Text(movie.title)
          .font(.headline)
          .lineLimit(2)
        
        if let releaseDate = movie.releaseDate, !releaseDate.isEmpty {
          Text(releaseDate)
            .font(.subheadline)
            .foregroundColor(.secondary)
        }
        if let overview = movie.overview, overview.count > 0 {
          Text(overview)
            .font(.caption)
            .foregroundColor(.secondary)
            .lineLimit(3)
        } else {
          Text("Overview not available")
            .font(.caption)
            .foregroundColor(.secondary)
        }
        
      }
      
      Spacer()
    }
    .padding(.vertical, 4)
  }
}

//#Preview {
//    MovieRowView()
//}
