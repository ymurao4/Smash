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

    @Environment(\.presentationMode) var presentatinoMode
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
            Button(action: {
                self.presentatinoMode.wrappedValue.dismiss()
            }){
                if isBeginEditing {
                    Text("Done")
                }
        })
            .onDisappear {
                self.onCommit(self.noteCellVM.note)
        }
    }
}

