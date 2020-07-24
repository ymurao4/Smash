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
            ForEach(frameVM.frameDatas) { data in
                Section(header: Text(data.name)) {
                    Text("\(data.frameStartup)   Frame Startup")
                        .font(.headline)
                    Text("\(data.totalFrames)   Total Frames")
                        .font(.headline)
                    Text("\(data.onShield)   On Shield")
                        .font(.headline)
                    Text("\(data.activeOn)   Active On")
                        .font(.headline)
                }
            }
        }
        .onAppear {
            self.frameVM.loadFrameData(fighterName: self.fighterName)
        }
        .navigationBarTitle(frameVM.repository.fighterName)
    }
}

