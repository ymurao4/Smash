//
//  WebView.swift
//  Smash
//
//  Created by 村尾慶伸 on 2020/07/27.
//  Copyright © 2020 村尾慶伸. All rights reserved.
//

import SwiftUI
import SafariServices

struct SafariView: UIViewControllerRepresentable {

    typealias UIViewControllerType = SFSafariViewController

    @Binding var fighterName: String

    func makeUIViewController(context: Context) -> SFSafariViewController {
        
        let urlString: String = "https://ultimateframedata.com/\(fighterName).php"
        let url = URL(string: urlString)
        return SFSafariViewController(url: url!)
    }

    func updateUIViewController(_ uiViewController: SFSafariViewController, context: Context) {
    }

}

