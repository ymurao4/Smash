//
//  NoteView.swift
//  Smash
//
//  Created by 村尾慶伸 on 2020/07/20.
//  Copyright © 2020 村尾慶伸. All rights reserved.
//

import SwiftUI

struct NoteView: View {

    @State var selectedIndex: Int = 0
    private let pickerName: [String] = ["メモ", "キャラ対メモ"]

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
                List {
                    ForEach(0..<S.fightersArray.count) { index in
                        NavigationLink(destination: NoteDetailView(fighterName: S.fightersArray[index][0])) {
                            HStack {
                                FighterPDF(name: S.fightersArray[index][1])
                                    .frame(width: 25, height: 25)
                                    .padding(.trailing, 5)
                                Text(S.fightersArray[index][0])
                            }
                        }
                    }
                    Text("")
                }
            }
            .padding(.horizontal, 20)
            .navigationBarTitle("メモ")
        }
    }
}

struct NoteView_Previews: PreviewProvider {
    static var previews: some View {
        NoteView()
    }
}
