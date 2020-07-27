//
//  NoteDetailView.swift
//  Smash
//
//  Created by 村尾慶伸 on 2020/07/25.
//  Copyright © 2020 村尾慶伸. All rights reserved.
//

import SwiftUI

struct NoteDetailView: View {

    @Environment(\.presentationMode) var presentatinoMode
    @ObservedObject var noteVM = NoteViewModel()
    @State var text: String = ""
    @State var fighterName: String = ""
    @Binding var isTabbarHidden: Bool

    var body: some View {
        VStack {
            MultilineTextField(text: $text)
        }
        .padding(.horizontal, 10)
        .navigationBarTitle(Text(""), displayMode: .inline)
        .navigationBarItems(trailing:
            Button(action: {
                self.noteVM.addNote(note: Note(text: self.text, fighterName: "wario"))
                self.presentatinoMode.wrappedValue.dismiss()
            }){
                Text("Done")
        })
            .onAppear {
                self.isTabbarHidden = true
        }
    }
}

