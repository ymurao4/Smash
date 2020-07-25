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
