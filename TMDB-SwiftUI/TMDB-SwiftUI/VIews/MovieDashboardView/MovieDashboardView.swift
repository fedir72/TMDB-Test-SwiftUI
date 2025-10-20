//
//  StartListView.swift
//  TMDB-SwiftUI
//
//  Created by ihor fedii on 04.10.25.
//

import SwiftUI

struct MovieDashboardView: View {
    var body: some View {
      NavigationView {
        List {
          MovieCarouselView(category: .upcoming,   cardType: .poster)
          MovieCarouselView(category: .nowPlaying, cardType: .backdrop)
          MovieCarouselView(category: .topRated,   cardType: .poster)
          MovieCarouselView(category: .popular,    cardType: .backdrop)
          
        }
        .listRowSeparator(.visible)
        .listStyle(.plain)
        .padding(.horizontal, -10)
        .navigationTitle("The Movie Database")
      }
    }
}

#Preview {
    MovieDashboardView()
}
