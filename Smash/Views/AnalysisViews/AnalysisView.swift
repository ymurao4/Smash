//
//  AnalysisView.swift
//  Smash
//
//  Created by 村尾慶伸 on 2020/07/21.
//  Copyright © 2020 村尾慶伸. All rights reserved.
//

import SwiftUI

struct AnalysisView: View {

    @State private var selectedIndex: Int = 0
    private let pickerName: [String] = ["メイン", "自分", "相手", "ステージ"]
    private let sortedName: [String] = ["キャラ", "試合", "勝ち", "負け", "勝率"]

    var body: some View {
        NavigationView {
            VStack {
                Picker("", selection: $selectedIndex) {
                    ForEach(0..<self.pickerName.count) { index in
                        Text(self.pickerName[index])
                            .tag(index)
                    }
                }
                .pickerStyle(SegmentedPickerStyle())
                .padding(.horizontal, 20)
                HStack {
                    ForEach(sortedName, id: \.self) { name in
                        Text(name)
                            .frame(maxWidth: .infinity)
                    }
                    .font(.subheadline)
                    .padding(EdgeInsets(top: 10, leading: 10, bottom: 0, trailing: 10))
                }
                if selectedIndex == 0 {
                    AnalysisMainFighterView()
                } else if selectedIndex == 1 {
                    AnalysisMyFighterView()
                } else if selectedIndex == 2 {
                    AnalysisOpponentFighterView()
                } else if selectedIndex == 3 {
                    AnalysisStageView()
                }
            }
            .navigationBarTitle("分析")
        }
    }
}

struct AnalysisView_Previews: PreviewProvider {
    static var previews: some View {
        AnalysisView()
    }
}
