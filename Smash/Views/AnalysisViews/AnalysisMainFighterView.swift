//
//  AnalysisMainViews.swift
//  Smash
//
//  Created by 村尾慶伸 on 2020/07/25.
//  Copyright © 2020 村尾慶伸. All rights reserved.
//

import SwiftUI

struct AnalysisMainFighterView: View {
    var body: some View {
        List {
            Section(header: Text("対戦相手")) {
                ForEach(0..<S.fightersArray.count) { index in
                    HStack() {
                        FighterPDF(name: S.fightersArray[index][1])
                            .frame(width: 25, height: 25)
                            .frame(maxWidth: .infinity)
                        Text("5")
                            .frame(maxWidth: .infinity)
                        Text("3")
                            .frame(maxWidth: .infinity)
                        Text("2")
                            .frame(maxWidth: .infinity)
                        Text("60.0%")
                            .lineLimit(1)
                            .minimumScaleFactor(0.2)
                            .frame(maxWidth: .infinity)
                    }
                }
            }
            Section(header: Text("ステージ")) {
                ForEach(0..<S.stageArray.count) { index in
                    HStack {
                        VStack(spacing: 0) {
                            StagePDF(name: S.stageArray[index][1])
                                .frame(width: 60, height: 30)
                                .cornerRadius(3)
                                .frame(maxWidth: .infinity)
                            Text(S.stageArray[index][0])
                                .font(.caption)
                        }
                        Text("4")
                            .frame(maxWidth: .infinity)
                        Text("3")
                            .frame(maxWidth: .infinity)
                        Text("1")
                            .frame(maxWidth: .infinity)
                        Text("75.0%")
                            .frame(maxWidth: .infinity)
                    }
                }
            }
            // tabbarで隠れてしまうため
            Text("")
        }
    }
}

struct AnalysisMainViews_Previews: PreviewProvider {
    static var previews: some View {
        AnalysisMainFighterView()
    }
}
