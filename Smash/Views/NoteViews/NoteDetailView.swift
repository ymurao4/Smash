//
//  NoteDetailView.swift
//  Smash
//
//  Created by 村尾慶伸 on 2020/07/25.
//  Copyright © 2020 村尾慶伸. All rights reserved.
//

import SwiftUI
import WaterfallGrid
import ExytePopupView

struct NoteDetailView: View {

    @ObservedObject var noteCellVM: NoteCellViewModel

    @State var isBeginEditing: Bool = false
    @State var isIconSetting: Bool = false
    @State var keyboardHeight: CGFloat = 0

    var onCommit: (Note) -> (Void) = { _ in }

    var body: some View {
        ZStack(alignment: .bottomTrailing) {
            // 入力中ではなく、isIconSettingがtrueの時表示
            MultilineTextField(text: $noteCellVM.note.text, isBeginEditing: $isBeginEditing)
            // アイコン設定
            Button(action: {
                self.isIconSetting.toggle()
                self.isBeginEditing = false
                UIApplication.shared.endEditing()
            }) {
                if self.noteCellVM.note.fighterName != "" && self.noteCellVM.note.fighterName != nil {
                    FighterPDF(name: self.noteCellVM.note.fighterName!)
                } else {
                    Image(systemName: "plus")
                        .resizable()
                        .frame(width: 15, height: 15)
                }
            }
            .frame(width: 45, height: 45)
            .background(Color(UIColor.systemGray2))
            .foregroundColor(Color.white)
            .cornerRadius(22.5)
            .animation(.spring())
            .offset(y: -self.keyboardHeight)
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
            }
        )
            .onDisappear {
                self.onCommit(self.noteCellVM.note)
        }
        .popup(isPresented: $isIconSetting, type: .toast, closeOnTap: true, closeOnTapOutside: true) {
            SelectFighterIcon(noteCellVM: self.noteCellVM, isIconSetting: self.$isIconSetting)
                .frame(maxHeight: UIScreen.main.bounds.height / 2)
                .background(Color(UIColor.systemGray2))
                .cornerRadius(30)
                .animation(.spring())
        }
        .onAppear {

            // keyboardの高さを取得
            NotificationCenter.default.addObserver(forName: UIResponder.keyboardWillShowNotification, object: nil, queue: .main) { (noti) in
                let value = noti.userInfo![UIResponder.keyboardFrameEndUserInfoKey] as! CGRect
                let height = value.height

                self.keyboardHeight = height
            }

            NotificationCenter.default.addObserver(forName: UIResponder.keyboardWillHideNotification, object: nil, queue: .main) { (noti) in

                self.keyboardHeight = 0
            }

        }
    }
}


struct SelectFighterIcon: View {

    @ObservedObject var noteCellVM: NoteCellViewModel
    @Binding var isIconSetting: Bool

    var body: some View {
        HStack(alignment: .center) {
            WaterfallGrid(S.fightersArray, id: \.self) { fighter in
                Button(action: {
                    self.noteCellVM.note.fighterName = fighter[1]
                    self.isIconSetting = false
                }) {
                    FighterPDF(name: fighter[1])
                        .frame(width: 30, height: 30)
                }
            }
            .gridStyle(columns: 8, spacing: 10, padding: EdgeInsets(top: 10, leading: 10, bottom: 5, trailing: 10))
            .scrollOptions(direction: .vertical, showsIndicators: false)
        }
    }

}
