//
//  NoteDetailView.swift
//  Smash
//
//  Created by 村尾慶伸 on 2020/07/25.
//  Copyright © 2020 村尾慶伸. All rights reserved.
//

import SwiftUI
import WaterfallGrid
import PartialSheet

struct NoteDetailView: View {

    @EnvironmentObject var partialSheetManager : PartialSheetManager
    @Environment (\.colorScheme) var colorScheme: ColorScheme
    @ObservedObject var noteCellVM: NoteCellViewModel

    @State private var isBeginEditing: Bool = false
    @State private var navBarHeight: CGFloat? = 0

    var onCommit: (Note) -> (Void) = { _ in }

    var body: some View {
        ZStack(alignment: .top) {
            // 入力中ではなく、isIconSettingがtrueの時表示
            // TODO: - paddingを入れるかどうか
            MultilineTextField(text: $noteCellVM.note.text, isBeginEditing: $isBeginEditing)
                .padding(10)
        }
        .navigationBarTitle(Text(""), displayMode: .inline)
        .navigationBarItems(trailing:
            // 入力中の時は、”Done”, iconをタップ時、popup
            HStack {
                Button(action: {
                    // partial sheet
                    self.partialSheetManager.showPartialSheet({
                         print("normal sheet dismissed")
                     }) {
                         SelectFighterIcon(noteCellVM: self.noteCellVM)
                     }

                    self.isBeginEditing = false
                    UIApplication.shared.endEditing()
                }) {
                    if self.noteCellVM.note.fighterName != "" && self.noteCellVM.note.fighterName != nil {
                        FighterPDF(name: self.noteCellVM.note.fighterName!)
                            .frame(width: 25, height: 25)
                    } else {
                        Image(systemName: "plus")
                            .resizable()
                            .frame(width: 20, height: 20)
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

    var body: some View {
        VStack {
            WaterfallGrid(S.fightersArray, id: \.self) { fighter in
                Button(action: {
                    self.noteCellVM.note.fighterName = fighter[1]
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

