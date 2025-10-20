//
//  MovieCardView.swift
//  TMDB-SwiftUI
//
//  Created by ihor fedii on 11.10.25.
//

import SwiftUI
import SDWebImageSwiftUI

struct MovieCardView: View {

    let movie: Movie
    let type: CardType
    
    // Вычисляемые свойства для ширины и высоты
    private var cardWidth: CGFloat {
        switch type {
        case .poster: return 200
        case .backdrop: return 300
        }
    }
    
    private var cardHeight: CGFloat {
        switch type {
        case .poster: return 300
        case .backdrop: return 169
        }
    }
    
    var body: some View {
        switch type {
        case .poster:
            WebImage(url: movie.posterURL)
                .resizable()
                .scaledToFill()
                .frame(width: cardWidth, height: cardHeight)
                .clipShape(RoundedRectangle(cornerRadius: 8))
                .shadow(radius: 3)
            
        case .backdrop:
            VStack(alignment: .leading, spacing: 4) {
                WebImage(url: movie.backdropURL)
                    .resizable()
                    .scaledToFill()
                    .frame(width: cardWidth, height: cardHeight)
                    .clipShape(RoundedRectangle(cornerRadius: 8))
                    .shadow(radius: 3)
                
                Text(movie.originalTitle)
                    .font(.caption)
                    .lineLimit(1)
                    .minimumScaleFactor(0.5)
            }
            .frame(width: cardWidth)
        }
    }
}

//#Preview {
//  MovieCardView(movie: <#Movie#>, type: .backdrop)
//}
