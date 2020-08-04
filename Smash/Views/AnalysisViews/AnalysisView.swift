//
//  AnalysisView.swift
//  Smash
//
//  Created by 村尾慶伸 on 2020/07/21.
//  Copyright © 2020 村尾慶伸. All rights reserved.
//

import SwiftUI
import WaterfallGrid
import PartialSheet

struct AnalysisView: View {

    @EnvironmentObject var partialSheetManager : PartialSheetManager
    @ObservedObject var analysisVM = AnalysisViewModel(sortName: "opponentFighter")
    @State private var selectedIndex: Int = 0
    private let pickerName: [String] = ["メイン", "自分", "相手", "ステージ"]
    private let sortedName: [String] = ["", "試合", "勝ち", "負け", "勝率"]

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
                HStack {
                    ForEach(sortedName, id: \.self) { name in
                        Text(name)
                            .frame(maxWidth: .infinity)
                    }
                    .font(.subheadline)
                    .padding(EdgeInsets(top: 10, leading: 20, bottom: 0, trailing: 10))
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
            .padding(.horizontal, 10)
            .navigationBarTitle("分析")
            .navigationBarItems(trailing:
                Button(action: {
                    self.partialSheetManager.showPartialSheet( {
                        print("normal sheet dismissed")
                    }) {
                        SelectMainFighterIcon(analysisVM: self.analysisVM)
                    }
                }) {
                    FighterPDF(name: self.analysisVM.mainFighter)
                        .frame(width: 30, height: 30)
                }
            )
        }
    }
}

struct AnalysisView_Previews: PreviewProvider {
    static var previews: some View {
        AnalysisView()
    }
}

struct SelectMainFighterIcon: View {

    @ObservedObject var analysisVM: AnalysisViewModel

    var body: some View {
        VStack {
            WaterfallGrid(S.fightersArray, id: \.self) { fighter in
                Button(action: {
                    self.analysisVM.updateMainFighter(fighterName: fighter[1])
                }) {
                    FighterPDF(name: fighter[1])
                        .frame(width: 40, height: 40)
                        .background(Color.orange)
                        .cornerRadius(20)
                }
            }
            .gridStyle(
                columns: 6,
                spacing: 5
            )
            .scrollOptions(
                direction: .vertical,
                showsIndicators: false
            )
        }
        .frame(maxHeight: UIScreen.main.bounds.size.height / 2)

    }
}
