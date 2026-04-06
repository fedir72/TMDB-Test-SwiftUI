//
//  ButtonExtensions.swift
//  TMDB-SwiftUI
//
//  Created by   Ihor Fedii on 06.04.26.
//

import SwiftUI


extension Button {
    func capsuleButtonShadow(
        backgroundColor: Color = .white,
        foregroundColor: Color? = nil, // по умолчанию nil
        shadowColor: Color = .black,
        shadowRadius: CGFloat = 4,
        shadowX: CGFloat = 0,
        shadowY: CGFloat = 2,
        padding: CGFloat = 8
    ) -> some View {
        self
            .frame(maxWidth: .infinity)
            .padding(padding)
            .background(
                Capsule()
                    .fill(backgroundColor)
                    .shadow(color: shadowColor.opacity(0.25),
                            radius: shadowRadius,
                            x: shadowX,
                            y: shadowY)
            )
            .applyIf(foregroundColor != nil) { view in
                view.foregroundColor(foregroundColor!)
            }
    }
}

// Вспомогательный модификатор, чтобы применять условно
extension View {
    @ViewBuilder
    func applyIf<T: View>(_ condition: Bool, transform: (Self) -> T) -> some View {
        if condition {
            transform(self)
        } else {
            self
        }
    }
}
