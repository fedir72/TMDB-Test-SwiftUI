//
//  SubViews.swift
//  TMDB-SwiftUI
//
//  Created by   Ihor Fedii on 04.04.26.
//

import SwiftUI

// MARK: - StarRatingView
struct StarRatingView: View {
    let rating: Double
    var body: some View {
        HStack(spacing: 2) {
            ForEach(1...10, id: \.self) { index in
                Image(systemName: index <= Int(round(rating)) ? "star.fill" : "star")
                    .foregroundColor(index <= Int(round(rating)) ? .yellow : .gray)
            }
        }
    }
}

//MARK: - VideoItemRow
struct VideoItemRow: View {
  let video: MovieVideo
  var body: some View {
    HStack {
      Image(systemName: "play.rectangle.fill")
        .foregroundColor(.red)
        .imageScale(.large)
      VStack(alignment: .leading, spacing: 4) {
        Text(video.name)
          .font(.subheadline)
          .foregroundColor(.primary)
          .lineLimit(1)
        Text(video.site)
          .font(.caption)
          .foregroundColor(.secondary)
      }
      Spacer()
      Image(systemName: "chevron.right")
        .foregroundColor(.secondary)
    }
    .padding(.horizontal)
  }
  
}

//MARK: - InfoBlockView
struct InfoBlockView: View {
    let title: String
    let content: String?

    var body: some View {
        if let content = content, !content.isEmpty {
            VStack(alignment: .leading, spacing: 2) {
                Text(title)
                    .movieTitleStyle()
                Text(content)
                    .font(.body)
                    .fixedSize(horizontal: false, vertical: true)
            }
        }
    }
}

