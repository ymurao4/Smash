//
//  NoteView.swift
//  Smash
//
//  Created by 村尾慶伸 on 2020/07/20.
//  Copyright © 2020 村尾慶伸. All rights reserved.
//

import SwiftUI

struct NoteView: View {

    @StateObject var noteVM = NoteViewModel()

    private func delete(offset: IndexSet) {

        let note = self.noteVM.noteCellViewModels[offset.first!].note
        self.noteVM.deleteNote(note: note)
    }

    var body: some View {

        NavigationView {

            VStack(alignment: .leading) {
                // Listの中に入れない！！！！！！！
                NewNoteCell(noteVM: noteVM)

                List {

                    ForEach(noteVM.noteCellViewModels) { noteCellVM in

                        NoteCell(noteVM: noteVM, noteCellVM: noteCellVM)
                    }
                    .onDelete(perform: delete)
                }
            }
            .navigationBarTitle("Note".localized)
            .navigationBarItems(trailing: EditButton())
        }
    }
}

struct NewNoteCell: View {

    @ObservedObject var noteVM: NoteViewModel

    var body: some View {

        NavigationLink(destination: NoteDetailView(noteVM: noteVM, noteCellVM: NoteCellViewModel(note: Note(text: "", imageURL: []))) { note in

            self.noteVM.addNote(note: note)
        }) {

            HStack {

                Image(systemName: "plus.circle.fill")
                    .resizable()
                    .frame(width: 20, height: 20)

                Text("Add new note".localized)
            }
            .padding(EdgeInsets(top: 10, leading: 20, bottom: 10, trailing: 20))
        }
    }

}


struct NoteCell: View {

    @ObservedObject var noteVM: NoteViewModel
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
                    Text(noteCellVM.firstLineText)
                        .lineLimit(1)
                    // 日付を表示
                    Text(self.noteCellVM.date)
                        .font(.caption)
                }
            }

            NavigationLink(destination: NoteDetailView(noteVM: noteVM, noteCellVM: noteCellVM)) { EmptyView() }
        }
        .padding(.vertical, 5)
    }
}



