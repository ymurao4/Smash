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
    @State private var noteID: String?
    @Binding var isHideTabbar: Bool

    private func delete(index: IndexSet) {
        self.noteID = self.noteVM.noteCellViewModels[index.first!].id
        self.noteVM.deleteNote(noteID: self.noteID)
    }

    var body: some View {
        NavigationView {
            VStack(alignment: .leading) {
                // Listの中に入れない！！！！！！！
                NewNoteCell(noteVM: noteVM)
                List {
                    ForEach(noteVM.noteCellViewModels) { noteCellVM in
                        NoteCell(noteCellVM: noteCellVM)
                    }
                    .onDelete { index in
                        self.delete(index: index)
                    }
                    // tabbarで隠れてしまうため
                    Text("")
                }
            }
            .padding(.horizontal, 10)
            .navigationBarTitle("メモ")
            .navigationBarItems(trailing: EditButton())
        }
    }
}

struct NewNoteCell: View {

    @ObservedObject var noteVM: NoteViewModel

    var body: some View {

        NavigationLink(destination: NoteDetailView(noteCellVM: NoteCellViewModel(note: Note(text: ""))) { note in
            self.noteVM.addNote(note: note)
        }) {
            HStack {
                Image(systemName: "plus.circle.fill")
                    .resizable()
                    .frame(width: 20, height: 20)
                Text("メモを追加")
            }
            .padding(EdgeInsets(top: 10, leading: 20, bottom: 10, trailing: 20))
        }
    }

}


struct NoteCell: View {

    @ObservedObject var noteCellVM: NoteCellViewModel

    var body: some View {
        // navigationlinkの>を消すため
        ZStack(alignment: .leading) {
            HStack {
                //fighterNameが nil と "" の時は else
                if noteCellVM.note.fighterName != nil && noteCellVM.note.fighterName != "" {
                    FighterPDF(name: noteCellVM.note.fighterName!)
                        .frame(width: 25, height: 25)
                        .padding(.trailing, 5)
                } else {
                    Image(systemName: "scribble")
                        .resizable()
                        .frame(width: 25, height: 25)
                        .cornerRadius(22.5)
                        .padding(.trailing, 5)
                }
                VStack(alignment: .leading) {
                    // メモの内容を表示
                    Text(noteCellVM.note.text)
                        .lineLimit(1)
                    // 日付を表示
                    Text(self.noteCellVM.date)
                        .font(.caption)
                }
            }
            NavigationLink(destination: NoteDetailView(noteCellVM: noteCellVM)) {
                EmptyView()
            }
        }
        .padding(.vertical, 5)
    }

}



