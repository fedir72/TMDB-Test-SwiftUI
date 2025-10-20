//
//  SafariView.swift
//  TMDB-SwiftUI
//
//  Created by ihor fedii on 11.10.25.
//

import SwiftUI
import SafariServices

//MARK: - SafariView
struct SafariWebView: UIViewControllerRepresentable {
    let url: URL
    
    func makeUIViewController(context: Context) -> SFSafariViewController {
        SFSafariViewController(url: url)
    }
    
    func updateUIViewController(_ uiViewController: SFSafariViewController, context: Context) {}
}
