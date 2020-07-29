//
//  NoteDetailView.swift
//  Smash
//
//  Created by 村尾慶伸 on 2020/07/25.
//  Copyright © 2020 村尾慶伸. All rights reserved.
//

import SwiftUI
import WaterfallGrid

struct NoteDetailView: View {

    @ObservedObject var noteCellVM: NoteCellViewModel

    @State var isBeginEditing: Bool = false
    @State var isIconSetting: Bool = false


    var onCommit: (Note) -> (Void) = { _ in }

    var body: some View {
        VStack {
            if isIconSetting {
                WaterfallGrid(S.fightersArray, id: \.self) { fighter in
                    Button(action: {
                        self.noteCellVM.note.fighterName = fighter[1]
                        self.isIconSetting = false
                    }) {
                        FighterPDF(name: fighter[1])
                        .frame(width: 25, height: 25)
                    }
                }
                .gridStyle(columns: 1, spacing: 10, padding: EdgeInsets(top: 8, leading: 3, bottom: 3, trailing: 3), animation: .easeInOut(duration: 1))
                .scrollOptions(direction: .horizontal, showsIndicators: false)
                .frame(maxHeight: 35)
            }
            MultilineTextField(text: $noteCellVM.note.text, isBeginEditing: $isBeginEditing)
        }
        .padding(.horizontal, 10)
        .navigationBarTitle(Text(""), displayMode: .inline)
        .navigationBarItems(trailing:
            HStack {
                Button(action: {
                    self.isIconSetting.toggle()
                }) {
                    if self.noteCellVM.note.fighterName == nil {
                        Image(systemName: "person.crop.circle.badge.plus")
                            .resizable()
                            .frame(width: 20, height: 20)
                    } else {
                        if self.noteCellVM.note.fighterName != "" {
                            FighterPDF(name: self.noteCellVM.note.fighterName!)
                                .frame(width: 20, height: 20)
                        }
                    }
                }
//                .padding(.trailing, 20)
                if isBeginEditing {
                    Button(action: {
                        self.isBeginEditing = false
                        UIApplication.shared.endEditing()
                    }){
                        Text("Done")
                    }
                }
            }
        )
            .onDisappear {
                self.onCommit(self.noteCellVM.note)
        }
    }
}

