//
//  LoadView.swift
//  TMDB-SwiftUI
//
//  Created by ihor fedii on 05.10.25.
//

import SwiftUI

struct LoadView: View {
    let text: String
    
    var body: some View {
        VStack(spacing: 12) {
            ProgressView()
                .progressViewStyle(CircularProgressViewStyle(tint: .blue))
                .scaleEffect(1.5) // увеличиваем индикатор
            
            Text(text)
                .font(.caption)
                .foregroundColor(.gray)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color(.systemBackground).opacity(0.8)) // полупрозрачный фон
    }
}

#Preview {
  LoadView(text: "information is loading")
}
