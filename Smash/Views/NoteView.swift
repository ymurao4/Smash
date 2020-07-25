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
    private let pickerName: [String] = ["キャラ対メモ", "その他"]
    let test = testNotes

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
                if selectedIndex == 0 {
                    FighterMeasuresNoteView()
                } else {
                    OtherNoteView(test: test)
                }
            }
            .navigationBarTitle("メモ")
        }
    }
}

struct NoteView_Previews: PreviewProvider {
    static var previews: some View {
        NoteView()
    }
}


struct FighterMeasuresNoteView: View {
    var body: some View {
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
}


struct OtherNoteView: View {

    let test: [Note]

    var body: some View {
        VStack(alignment: .leading) {
            Button(action: {}) {
                HStack {
                    Image(systemName: "plus.circle.fill")
                        .resizable()
                        .frame(width: 20, height: 20)
                    Text("メモを追加")
                }
            }
            .padding()
            .padding(.leading, 5)
            List {
                ForEach(test) { t in
                    HStack {
                        Text(t.text)
                        FighterPDF(name: t.fighter).frame(width: 25, height: 25)
                    }
                }
            }
        }
    }
}
