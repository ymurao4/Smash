//
//  StagePDF.swift
//  Smash
//
//  Created by 村尾慶伸 on 2020/07/21.
//  Copyright © 2020 村尾慶伸. All rights reserved.
//

import Foundation
import SwiftUI

struct StagePDF: UIViewRepresentable {

    var name: String

    func makeUIView(context: Context) -> UIImageView {
        let imageView = UIImageView()
        imageView.setContentCompressionResistancePriority(.fittingSizeLevel, for: .vertical)
        return imageView
    }

    func updateUIView(_ uiView: UIImageView, context: Context) {
        uiView.contentMode = .scaleAspectFit
        
        if let image = UIImage(named: name) {
            uiView.image = image.withAlignmentRectInsets(UIEdgeInsets(top: 50, left: 50, bottom: 50, right: 50))
        }
    }

}
