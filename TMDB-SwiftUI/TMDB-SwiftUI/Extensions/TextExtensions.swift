//
//  TextExtensions.swift
//  TMDB-SwiftUI
//
//  Created by ihor fedii on 14.10.25.
//

import SwiftUI

extension Text {
    func movieTitleStyle() -> some View {
        self
        .font(.headline)
        .bold()
        .foregroundColor(.red)
    }
}
