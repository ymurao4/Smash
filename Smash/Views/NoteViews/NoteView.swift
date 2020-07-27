//
//  NoteView.swift
//  Smash
//
//  Created by 村尾慶伸 on 2020/07/20.
//  Copyright © 2020 村尾慶伸. All rights reserved.
//

import SwiftUI

struct NoteView: View {

    @ObservedObject var noteVM = NoteViewModel()
    @Binding var isTabbarHidden: Bool
    @State var noteID: String?

    func delete(index: IndexSet) {
        self.noteID = self.noteVM.noteCellViewModels[index.first!].id
        self.noteVM.deleteNote(noteID: self.noteID)
    }

    var body: some View {
        NavigationView {
            VStack(alignment: .leading) {
                NavigationLink(destination: NoteDetailView(isTabbarHidden: $isTabbarHidden)){
                    HStack {
                        Image(systemName: "plus.circle.fill")
                            .resizable()
                            .frame(width: 20, height: 20)
                        Text("メモを追加")
                    }
                    .padding()
                }
                List {
                    ForEach(noteVM.noteCellViewModels) { noteCellVM in
                        NoteCell(noteCellVM: noteCellVM, isTabbarHidden: self.$isTabbarHidden)
                    }
                    .onDelete { index in
                        self.delete(index: index)
                    }
                    Text("")
                }
            }
            .padding(.horizontal, 20)
            .navigationBarTitle("メモ")
            .onAppear {
                self.isTabbarHidden = false
            }
        }
    }
}


struct NoteCell: View {

    @ObservedObject var noteCellVM: NoteCellViewMdoel
    @Binding var isTabbarHidden: Bool

    var body: some View {
        NavigationLink(destination: NoteDetailView(text: noteCellVM.note.text, isTabbarHidden: self.$isTabbarHidden)) {
            HStack {
                FighterPDF(name: noteCellVM.note.fighterName)
                    .frame(width: 25, height: 25)
                    .padding(.trailing, 5)
                Text(noteCellVM.note.text)
                    .lineLimit(1)
            }
        }
    }

}



