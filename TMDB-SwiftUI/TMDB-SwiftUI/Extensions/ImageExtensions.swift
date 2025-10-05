//
//  ImageExtensions.swift
//  TMDB-SwiftUI
//
//  Created by ihor fedii on 04.10.25.
//

import SwiftUI


extension Image {
  /// Resize an image with fill aspect ratio and specified frame dimensions.
  ///   - parameters:
  ///     - width: Frame width.
  ///     - height: Frame height.
  func resizedToFill(width: CGFloat, height: CGFloat) -> some View {
    self
      .resizable()
      .aspectRatio(contentMode: .fit)
      .frame(width: width, height: height)
  }
}


extension View {
  
  //MARK: - apologizeView
  func apologizeView(with text: String) -> some View {
    VStack(alignment: .center) {
         Image(systemName: "exclamationmark.triangle")
           .font(.largeTitle)
         Text(text)
           .multilineTextAlignment(.center)
           .font(.title2)
     }
     .foregroundStyle(.red)
   }
}

