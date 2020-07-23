//
//  FrameDetaleView.swift
//  Smash
//
//  Created by 村尾慶伸 on 2020/07/23.
//  Copyright © 2020 村尾慶伸. All rights reserved.
//

import SwiftUI

struct FrameDetaleView: View {

    @ObservedObject var frameVM = FrameViewModel()
    @State var fighterName: String

    var body: some View {
        List {
            FighterPNG(name: frameVM.repository.fighterName)
            ForEach(frameVM.frameCellViewModels) { data in
                Section(header: Text(data.frame.name)) {
                    Text("\(data.frame.frameStartup)   Frame Startup")
                        .font(.headline)
                    Text("\(data.frame.totalFrames)   Total Frames")
                        .font(.headline)
                    Text("\(data.frame.onShield)   On Shield")
                        .font(.headline)
                    Text("\(data.frame.activeOn)   Active On")
                        .font(.headline)
                }
            }
        }
        .navigationBarTitle(frameVM.repository.fighterName)
    }
}

