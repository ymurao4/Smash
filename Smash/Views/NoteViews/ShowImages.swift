//
//  ShowImages.swift
//  Smash
//
//  Created by 村尾慶伸 on 2020/08/15.
//  Copyright © 2020 村尾慶伸. All rights reserved.
//

import SwiftUI
import Pages

struct ShowImages: View {

    let imagesArray: [UIImage]
    @Environment(\.presentationMode) var presentationMode
    @Binding var selectedIndex: Int

    var body: some View {
        VStack {
            ModelPages(imagesArray, currentPage: $selectedIndex) { _, image in
                Image(uiImage: image)
                    .resizable()
                    .scaledToFit()
                .gesture(MagnificationGesture())
            }
            .padding()
        }
    }
}
