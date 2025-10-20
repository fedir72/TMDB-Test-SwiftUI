//
//  StartTabbarView.swift
//  TMDB-SwiftUI
//
//  Created by ihor fedii on 06.10.25.
//

import SwiftUI

struct StartTabbarView: View {
    var body: some View {
      NavigationView {
        TabView {
          MovieDashboardView()
            .tabItem {
              Label("Home", systemImage: "film.fill")
            }
          MovieSearchView()
            .tabItem {
              Label("search", systemImage: "magnifyingglass.circle")
            }
        }
      }
    }
}

#Preview {
    StartTabbarView()
}
