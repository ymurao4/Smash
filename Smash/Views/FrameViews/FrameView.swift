//
//  FrameView.swift
//  Smash
//
//  Created by 村尾慶伸 on 2020/07/21.
//  Copyright © 2020 村尾慶伸. All rights reserved.
//

import SwiftUI
import WaterfallGrid

struct Kind: Identifiable {
    var id: Int
    var jaName: String
    var fileName: String
}

struct FrameView: View {

    @Environment (\.colorScheme) var colorScheme: ColorScheme
    @State private var isActionSheet: Bool = false
    @State private var isSheet: Bool = false
    @State private var selectedIndex: Int = 0

    private var kinds: [Kind] = [
        Kind(id: 0, jaName: "重量", fileName: "Weight"),
        Kind(id: 1, jaName: "空中加速", fileName: "AirAcceleration"),
        Kind(id: 2, jaName: "空中移動", fileName: "AirSpeed"),
        Kind(id: 3, jaName: "落下", fileName: "FallSpeed"),
        Kind(id: 4, jaName: "ダッシュ", fileName: "DashSpeed"),
        Kind(id: 5, jaName: "歩行", fileName: "WalkSpeed"),
        Kind(id: 6, jaName: "走行", fileName: "RunSpeed")

    ]

    var body: some View {
        NavigationView{
            VStack {
                WaterfallGrid(0..<S.frameFighterArray.count, id: \.self) { index in
                    NavigationLink(destination: FrameDetaleView(fighterName: S.frameFighterArray[index])) {
                        ZStack(alignment: .bottom) {
                            FighterPNG(name: S.frameFighterArray[index])
                                .frame(width: 70, height: 70)
                                .overlay(
                                    Rectangle()
                                        .stroke(Color.orange, lineWidth: 1)
                            )
                            Text(T.translateFrameFighterName(name: S.frameFighterArray[index]))
                                .font(Font.system(size: 10))
                                .foregroundColor(Color.backgroundColor(for: self.colorScheme))
                        }
                    }
                }
                .gridStyle(columns: 5, spacing: 0, padding: EdgeInsets(top: 10, leading: 10, bottom: 60, trailing: 10))
                .scrollOptions(direction: .vertical, showsIndicators: false)
            }
            .navigationBarTitle("フレーム表")
            .navigationBarItems(trailing:
                Button(action: {
                    self.isActionSheet.toggle()
                }) {
                    Image(systemName: "text.aligncenter")
                        .resizable()
                        .frame(width: 20, height: 20)
                }
            )
                .actionSheet(isPresented: $isActionSheet) {
                    actionSheet()
            }
            .sheet(isPresented: $isSheet) {
                RankingView(kind: self.kinds[self.selectedIndex])
            }
        }
    }

    private func actionSheet() -> ActionSheet {
        ActionSheet(
            title: Text("ランキング"),
            buttons: [
                .default(Text("重量")) {
                    self.selectedIndex = 0
                    self.isSheet.toggle()
                },
                .default(Text("空中加速")) {
                    self.selectedIndex = 1
                    self.isSheet.toggle()
                },
                .default(Text("空中移動")) {
                    self.selectedIndex = 2
                    self.isSheet.toggle()
                },
                .default(Text("落下")) {
                    self.selectedIndex = 3
                    self.isSheet.toggle()
                },
                .default(Text("ダッシュ")) {
                    self.selectedIndex = 4
                    self.isSheet.toggle()
                },
                .default(Text("歩行")) {
                    self.selectedIndex = 5
                    self.isSheet.toggle()
                },
                .default(Text("走行")) {
                    self.selectedIndex = 6
                    self.isSheet.toggle()
                },
                .cancel()
            ]
        )
    }
}

struct FrameView_Previews: PreviewProvider {
    static var previews: some View {
        FrameView()
    }
}
/*
Kind(id: 0, jaName: "フレーム", fileName: "Frame"),
Kind(id: 1, jaName: "重量", fileName: "Weight"),
Kind(id: 2, jaName: "空中加速", fileName: "AirAcceleration"),
Kind(id: 3, jaName: "空中移動", fileName: "AirSpeed"),
Kind(id: 4, jaName: "落下", fileName: "FallSpeed"),
Kind(id: 5, jaName: "ダッシュ", fileName: "DashSpeed"),
Kind(id: 6, jaName: "歩行", fileName: "WalkSpeed"),
Kind(id: 7, jaName: "走行", fileName: "RunSpeed")
*/
