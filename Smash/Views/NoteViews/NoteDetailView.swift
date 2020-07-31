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

    @Environment (\.colorScheme) var colorScheme:ColorScheme
    @ObservedObject var noteCellVM: NoteCellViewModel

    @State private var isBeginEditing: Bool = false
    @State private var isIconSetting: Bool = false
    @State private var navBarHeight: CGFloat? = 0

    var onCommit: (Note) -> (Void) = { _ in }

    var body: some View {
        ZStack(alignment: .top) {
            // 入力中ではなく、isIconSettingがtrueの時表示
            // TODO: - paddingを入れるかどうか
            MultilineTextField(text: $noteCellVM.note.text, isBeginEditing: $isBeginEditing)
            // pop up icon
            if isIconSetting && !isBeginEditing {
                GeometryReader { _ in
                    SelectFighterIcon(noteCellVM: self.noteCellVM, isIconSetting: self.$isIconSetting)
                }
                .background(Color.black.opacity(0.65))
                .edgesIgnoringSafeArea(.all)
                .onTapGesture {
                    withAnimation {
                        self.isIconSetting = false
                    }
                }
            }
        }
        .navigationBarTitle(Text(""), displayMode: .inline)
        .navigationBarItems(trailing:
            // 入力中の時は、”Done”, iconをタップ時、popup
            HStack {
                Button(action: {
                    withAnimation {
                        self.isIconSetting.toggle()
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
    @Binding var isIconSetting: Bool

    var body: some View {
        VStack {
            WaterfallGrid(S.fightersArray, id: \.self) { fighter in
                Button(action: {
                    self.noteCellVM.note.fighterName = fighter[1]
                    withAnimation {
                        self.isIconSetting = false
                    }
                }) {
                    FighterPDF(name: fighter[1])
                        .frame(width: 30, height: 30)
                }
            }
            .gridStyle(columns: 8, spacing: 8, padding: EdgeInsets(top: 15, leading: 10, bottom: 15, trailing: 10))
            .scrollOptions(direction: .vertical, showsIndicators: false)
            .background(Color(UIColor.systemGray))
            .frame(maxHeight: UIScreen.main.bounds.height / 2)
            .cornerRadius(30)
            .animation(.easeInOut(duration: 2))
            .offset(y: 15)

            // off button
            Button(action: {
                self.noteCellVM.note.fighterName = ""
                withAnimation {
                    self.isIconSetting = false
                }
            }) {
                Image(systemName: "multiply")
                    .resizable()
                    .frame(width: 20, height: 20)
                    .foregroundColor(.white)
                    .padding()
            }
            .background(Color(UIColor.systemGray))
            .cornerRadius(30)
            .padding(.top, 20)
        }
    }

}
