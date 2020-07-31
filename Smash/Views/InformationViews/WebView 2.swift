//
//  WebView.swift
//  Smash
//
//  Created by 村尾慶伸 on 2020/07/27.
//  Copyright © 2020 村尾慶伸. All rights reserved.
//

import SwiftUI
import WebKit

struct WebView: UIViewRepresentable {

    let fighterName: String

    func makeUIView(context: Context) -> WKWebView {
        return WKWebView()
    }

    func updateUIView(_ uiView: WKWebView, context: Context) {

        let urlString: String = "https://ultimateframedata.com/\(fighterName).php"

        if let url = URL(string: urlString) {
            let request = URLRequest(url: url)
            uiView.load(request)
        }

    }

}
