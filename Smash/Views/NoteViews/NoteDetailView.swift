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
        ZStack(alignment: .trailing) {
            // 入力中ではなく、isIconSettingがtrueの時表示
            MultilineTextField(text: $noteCellVM.note.text, isBeginEditing: $isBeginEditing)
            // アイコン設定
            if isBeginEditing {
                if isIconSetting {
                    HStack {
                        WaterfallGrid(S.fightersArray, id: \.self) { fighter in
                            Button(action: {
                                self.noteCellVM.note.fighterName = fighter[1]
                                self.isIconSetting = false
                            }) {
                                FighterPDF(name: fighter[1])
                                    .frame(width: 30, height: 30)
                            }
                        }
                        .gridStyle(columns: 8, spacing: 10, padding: EdgeInsets(top: 50, leading: 0, bottom: 0, trailing: 0), animation: .easeInOut(duration: 1))
                        .scrollOptions(direction: .vertical, showsIndicators: false)
                    }
                    .offset(y: -40)
                } else {
                    Button(action: {
                        self.isIconSetting.toggle()
                    }) {
                        Image(systemName: "plus")
                            .resizable()
                            .frame(width: 15, height: 15)
                    }
                    .frame(width: 40, height: 40)
                    .background(Color(UIColor.systemGray2))
                    .foregroundColor(Color.white)
                    .cornerRadius(20)
                    .offset(y: 40)
                }
            }
        }
        .padding(.horizontal, 10)
        .navigationBarTitle(Text(""), displayMode: .inline)
        .navigationBarItems(trailing:
            // 入力中の時は、”Done”、そうでない時は”Icon”、ファイターを設定していない、または、""の時,systemImage
            HStack {
                if isBeginEditing {
                    Button(action: {
                        self.isBeginEditing.toggle()
                        UIApplication.shared.endEditing()
                    }) {
                        Text("Done")
                    }
                }
//                else {
//                    if self.noteCellVM.note.fighterName != nil && self.noteCellVM.note.fighterName != "" {
//                        Button(action: {
//                            self.noteCellVM.note.fighterName = ""
//                        }) {
//                            Image(systemName: "multiply")
//                                .resizable()
//                                .frame(width: 16, height: 16)
//                        }
//                        .padding(.trailing, 10)
//                    }
//                    Button(action: {
//                        self.isIconSetting.toggle()
//                    }) {
//                        if self.noteCellVM.note.fighterName == nil || self.noteCellVM.note.fighterName == "" {
//                            Image(systemName: "person.crop.circle.badge.plus")
//                                .resizable()
//                                .frame(width: 23, height: 23)
//                        } else {
//                            if self.noteCellVM.note.fighterName != "" {
//                                FighterPDF(name: self.noteCellVM.note.fighterName!)
//                                    .frame(width: 25, height: 25)
//                            }
//                        }
//                    }
//                }
            }
        )
            .onDisappear {
                self.onCommit(self.noteCellVM.note)
        }
    }
}

