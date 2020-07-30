//
//  NoteDetailView.swift
//  Smash
//
//  Created by 村尾慶伸 on 2020/07/25.
//  Copyright © 2020 村尾慶伸. All rights reserved.
//

import SwiftUI
import ExytePopupView
import WaterfallGrid

struct NoteDetailView: View {

    @ObservedObject var noteCellVM: NoteCellViewModel

    @State private var isBeginEditing: Bool = false
    @State private var isIconSetting: Bool = false
    @State private var navBarHeight: CGFloat? = 0

    var onCommit: (Note) -> (Void) = { _ in }

    var body: some View {
        ZStack(alignment: .bottomTrailing) {
            // 入力中ではなく、isIconSettingがtrueの時表示
            MultilineTextField(text: $noteCellVM.note.text, isBeginEditing: $isBeginEditing)
        }
        .padding(.horizontal, 10)
        .navigationBarTitle(Text(""), displayMode: .inline)
        .navigationBarItems(trailing:
            // 入力中の時は、”Done”, iconをタップ時、popup
            HStack {
                Button(action: {
                    self.isIconSetting.toggle()
                    self.isBeginEditing = false
                    UIApplication.shared.endEditing()
                }) {
                    if self.noteCellVM.note.fighterName != "" && self.noteCellVM.note.fighterName != nil {
                        FighterPDF(name: self.noteCellVM.note.fighterName!)
                            .frame(width: 25, height: 25)
                    } else {
                        Image(systemName: "plus")
                            .resizable()
                            .frame(width: 15, height: 15)
                    }
                }
                if isBeginEditing {
                    Button(action: {
                        self.isBeginEditing.toggle()
                        UIApplication.shared.endEditing()
                    }) {
                        Text("Done")
                    }
                }
            }
        )
            .onDisappear {
                self.onCommit(self.noteCellVM.note)
        }
        .popup(isPresented: $isIconSetting, position: .bottom, closeOnTap: true, closeOnTapOutside: true) {
            SelectFighterIcon(noteCellVM: self.noteCellVM, isIconSetting: self.$isIconSetting)
                .frame(maxHeight: UIScreen.main.bounds.height / 2)
                .background(Color(UIColor.systemGray2))
                .cornerRadius(30)
        }
        .zIndex(1)
        .onAppear {

            // navigationbarの高さを取得
            let window = UIApplication.shared.windows.filter {$0.isKeyWindow}.first
            self.navBarHeight = window?.windowScene?.statusBarManager?.statusBarFrame.height

        }
    }
}

// popup
struct SelectFighterIcon: View {

    @ObservedObject var noteCellVM: NoteCellViewModel
    @Binding var isIconSetting: Bool

    var body: some View {
        WaterfallGrid(S.fightersArray, id: \.self) { fighter in
            Button(action: {
                self.noteCellVM.note.fighterName = fighter[1]
                self.isIconSetting = false
            }) {
                FighterPDF(name: fighter[1])
                    .frame(width: 30, height: 30)
            }
        }
        .gridStyle(columns: 8, spacing: 8, padding: EdgeInsets(top: 30, leading: 10, bottom: 0, trailing: 10))
        .scrollOptions(direction: .vertical, showsIndicators: false)
    }

}
