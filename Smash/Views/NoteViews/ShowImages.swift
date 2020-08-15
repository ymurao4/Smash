//
//  ShowImages.swift
//  Smash
//
//  Created by 村尾慶伸 on 2020/08/15.
//  Copyright © 2020 村尾慶伸. All rights reserved.
//

import SwiftUI

struct ShowImages: View {
    let imagesArray: [UIImage]

    var body: some View {
        ScrollView(.horizontal) {
            HStack(alignment: .center) {
                ForEach(imagesArray.indices, id: \.self) { i in
                    Image(uiImage: self.imagesArray[i])
                        .resizable()
                        .scaledToFit()
                        .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height * 0.9)
                }
            }
        }
    }
}
