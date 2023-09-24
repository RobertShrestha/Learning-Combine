//
//  WebView.swift
//  HackerNews
//
//  Created by Robert Shrestha on 9/24/23.
//

import Foundation
import SwiftUI
import WebKit

struct WebView: UIViewRepresentable {
    var url: String
    typealias UIViewType = WKWebView
    func makeUIView(context: Context) -> WKWebView {
        guard let url = URL(string: self.url) else {
            return WKWebView.pageNotFoundView()
        }

        let request = URLRequest(url: url)

        let wkWebView = WKWebView()
        wkWebView.load(request)
        return wkWebView
    }

    func updateUIView(_ uiView: UIViewType, context: Context) {
        guard let url = URL(string: self.url) else {
            return
        }

        let request = URLRequest(url: url)
        uiView.load(request)
    }
}
