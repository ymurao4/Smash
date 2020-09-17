//
//  RankingView.swift
//  Smash
//
//  Created by 村尾慶伸 on 2020/07/31.
//  Copyright © 2020 村尾慶伸. All rights reserved.
//

import SwiftUI

struct RankingView: View {

    @ObservedObject var rankingVM = RankingViewModel()
    @State var rankingName: String = ""
    @State var kind: Kind

    var body: some View {

        NavigationView {

            List {

                ForEach(rankingVM.rankingData) { data in

                    HStack(spacing: 20) {

                        FighterPNG(name: data.fighterName)
                            .frame(width: 80, height: 80)

                        Text(T.translateFighterName(name: data.fighterName))
                            .font(.headline)

                        Spacer()

                        Text(data.value)
                            .font(.headline)
                    }
                    .padding(.trailing, 20)
                }
            }
            .edgesIgnoringSafeArea(.bottom)
            .navigationBarTitle(kind.name.localized)
            .onAppear {
                
                self.rankingVM.loadRankingData(rankingName: self.kind.fileName)
            }
        }
    }
}
