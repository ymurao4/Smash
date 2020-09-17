//
//  FrameView.swift
//  Smash
//
//  Created by 村尾慶伸 on 2020/07/21.
//  Copyright © 2020 村尾慶伸. All rights reserved.
//

import SwiftUI

struct Kind: Identifiable {
    var id: Int
    var name: String
    var fileName: String
}

struct FrameView: View {

    @Environment (\.colorScheme) var colorScheme: ColorScheme
    @State private var isActionSheet: Bool = false
    @State private var isSheet: Bool = false
    @State private var selectedIndex: Int = 0
    let column = GridItem(.flexible(minimum: 60, maximum: 80))

    private var kinds: [Kind] = [
        Kind(id: 0, name: "Weight", fileName: "Weight"),
        Kind(id: 1, name: "Air Accel", fileName: "AirAcceleration"),
        Kind(id: 2, name: "Air Speed", fileName: "AirSpeed"),
        Kind(id: 3, name: "Fall Speed", fileName: "FallSpeed"),
        Kind(id: 4, name: "Dash Speed", fileName: "DashSpeed"),
        Kind(id: 5, name: "Walk Speed", fileName: "WalkSpeed"),
        Kind(id: 6, name: "Run Speed", fileName: "RunSpeed")

    ]

    var body: some View {

        NavigationView{

            ScrollView(showsIndicators: false) {

                LazyVGrid(columns: Array(repeating: column, count: 5), spacing: 20) {

                    ForEach(S.frameFighterArray, id: \.self) { item in

                        NavigationLink(destination: FrameDetaleView(fighterName: item)) {

                            FighterPNG(name: item)
                                .frame(width: 60, height: 60)
                        }
                    }
                }
            }
            .padding(.horizontal)
            .navigationBarTitle("Frame".localized)
            .navigationBarItems(trailing:

                Button(action: { self.isActionSheet.toggle() }) {

                    Image(systemName: "line.horizontal.3")
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

            title: Text("Ranking".localized),
            buttons: [
                .default(Text(kinds[0].name.localized)) {
                    self.selectedIndex = 0
                    self.isSheet.toggle()
                },
                .default(Text(kinds[1].name.localized)) {
                    self.selectedIndex = 1
                    self.isSheet.toggle()
                },
                .default(Text(kinds[2].name.localized)) {
                    self.selectedIndex = 2
                    self.isSheet.toggle()
                },
                .default(Text(kinds[3].name.localized)) {
                    self.selectedIndex = 3
                    self.isSheet.toggle()
                },
                .default(Text(kinds[4].name.localized)) {
                    self.selectedIndex = 4
                    self.isSheet.toggle()
                },
                .default(Text(kinds[5].name.localized)) {
                    self.selectedIndex = 5
                    self.isSheet.toggle()
                },
                .default(Text(kinds[6].name.localized)) {
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

