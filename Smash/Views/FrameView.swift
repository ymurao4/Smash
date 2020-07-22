//
//  FrameView.swift
//  Smash
//
//  Created by 村尾慶伸 on 2020/07/21.
//  Copyright © 2020 村尾慶伸. All rights reserved.
//

import SwiftUI

struct FrameView: View {

    @ObservedObject var frameVM = FrameViewModel()

    var body: some View {

        NavigationView {
            VStack {
                List() {
                    HStack {
                        Spacer()
                        FighterPNG(name: "wario")
                            .frame(width: 200, height: 200)
                        Spacer()
                    }
                }
                .onAppear {
                    self.frameVM.loadData()
                }
                .navigationBarTitle("wario")
            }
        }
    }
}
struct FrameView_Previews: PreviewProvider {
    static var previews: some View {
        FrameView()
    }
}
