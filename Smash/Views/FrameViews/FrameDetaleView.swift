//
//  FrameDetaleView.swift
//  Smash
//
//  Created by 村尾慶伸 on 2020/07/23.
//  Copyright © 2020 村尾慶伸. All rights reserved.
//
import SwiftUI

struct FrameDetaleView: View {

    @Environment (\.colorScheme) var colorScheme:ColorScheme

    @ObservedObject var frameVM = FrameViewModel()

    @State  var isSheet: Bool = false
    @State var fighterName: String
    
    var body: some View {
        ZStack {
            List {
                FighterPNG(name: fighterName)
                ForEach(frameVM.frameData) { data in
                    Section(header: Text(data.name)) {
                        HStack {
                            Text(data.frameStartup)
                            Text("Frame Startup")
                        }
                        HStack {
                            Text(data.totalFrames)
                            Text("Total Frames")
                        }
                        HStack {
                            Text(data.onShield)
                            Text("On Shield")
                        }
                        HStack {
                            Text(data.activeOn)
                            Text("Active On")
                        }
                    }
                    .font(.headline)
                }
            }
            .sheet(isPresented: $isSheet) {
                SafariView(fighterName: self.fighterName)
                    .edgesIgnoringSafeArea(.bottom)
            }
        }
        .navigationBarBackButtonHidden(isSheet)
        .navigationBarTitle(T.translateFighterName(name: self.fighterName))
        .navigationBarItems(
            trailing:
            Button(action: {
                self.isSheet.toggle()
            }) {
                if !isSheet {
                    Image(systemName: "link")
                        .resizable()
                        .frame(width: 20, height: 20)
                }
            }
        )
            .onAppear {
                self.frameVM.loadFrameData(fighterName: self.fighterName)
        }
    }
}

