//
//  AnalysisView.swift
//  Smash
//
//  Created by 村尾慶伸 on 2020/07/21.
//  Copyright © 2020 村尾慶伸. All rights reserved.
//

import SwiftUI

struct AnalysisView: View {

    @State var selectedIndex: Int = 0
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
                HStack {
                    ForEach(sortedName, id: \.self) { name in
                        Text(name)
                            .frame(maxWidth: .infinity)
                    }
                }
                .font(.subheadline)
                .padding(EdgeInsets(top: 10, leading: 10, bottom: 0, trailing: 10))
                List {
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
            }
            .padding()
            .navigationBarTitle("分析")
        }
    }
}

struct AnalysisView_Previews: PreviewProvider {
    static var previews: some View {
        AnalysisView()
    }
}
