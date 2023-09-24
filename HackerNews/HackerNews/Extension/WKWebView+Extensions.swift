//
//  WKWebView+Extensions.swift
//  HackerNews
//
//  Created by Robert Shrestha on 9/24/23.
//

import Foundation
import WebKit

extension WKWebView {

    static func pageNotFoundView() -> WKWebView {

        let wk = WKWebView()
        wk.loadHTMLString("<html><body><h1>Page not found!</h1></body></html>", baseURL: nil)
        return wk

    }

}
