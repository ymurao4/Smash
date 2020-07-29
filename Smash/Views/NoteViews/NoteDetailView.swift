//
//  NoteDetailView.swift
//  Smash
//
//  Created by 村尾慶伸 on 2020/07/25.
//  Copyright © 2020 村尾慶伸. All rights reserved.
//

import SwiftUI

struct NoteDetailView: View {

    @ObservedObject var noteCellVM: NoteCellViewModel

    @State var isBeginEditing: Bool = false


    var onCommit: (Note) -> (Void) = { _ in }

    var body: some View {
        VStack {
            MultilineTextField(text: $noteCellVM.note.text, isBeginEditing: $isBeginEditing)
        }
        .padding(.horizontal, 10)
        .navigationBarTitle(Text(""), displayMode: .inline)
        .navigationBarItems(trailing:
            HStack {
                Button(action: {

                }) {
                    FighterPDF(name: "wario")
                        .frame(width: 20, height: 20)
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

