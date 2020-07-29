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

    private func delete(index: IndexSet) {
        self.noteID = self.noteVM.noteCellViewModels[index.first!].id
        self.noteVM.deleteNote(noteID: self.noteID)
    }

    var body: some View {
        NavigationView {
            VStack(alignment: .leading) {
                // Listの中に入れない！！！！！！！
                NewNoteCell(noteVM: noteVM, isTabbarHidden: $isTabbarHidden)
                List {
                    ForEach(noteVM.noteCellViewModels) { noteCellVM in
                        NoteCell(noteCellVM: noteCellVM, isTabbarHidden: self.$isTabbarHidden)
                    }
                    .onDelete { index in
                        self.delete(index: index)
                    }
                    // tabbarで隠れてしまうため
                    Text("")
                }
            }
            .padding(.horizontal, 20)
            .navigationBarTitle("メモ")
            .navigationBarItems(trailing: EditButton())
            .onAppear {
                self.isTabbarHidden = false
            }
        }
    }
}

struct NewNoteCell: View {

    @ObservedObject var noteVM: NoteViewModel
    @Binding var isTabbarHidden: Bool

    var body: some View {

        // NoteCellと同じことをするとNoteが追加されない
        NavigationLink(destination: NoteDetailView(noteCellVM: NoteCellViewModel(note: Note(text: ""))) { note in
            self.noteVM.addNote(note: note)
        }) {
            HStack {
                Image(systemName: "plus.circle.fill")
                    .resizable()
                    .frame(width: 20, height: 20)
                Text("メモを追加")
            }
        }
        .padding(15)
    }

}


struct NoteCell: View {

    @ObservedObject var noteCellVM: NoteCellViewModel
    @Binding var isTabbarHidden: Bool

    var body: some View {
        // ontapでは様々なバグが発生（遷移しない、isTabbarHiddenがtrueにならないなど）
        ZStack(alignment: .leading) {
            Button(action: {
                self.isTabbarHidden = true
            }) {
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
                    VStack {
                        Text(noteCellVM.note.text)
                            .lineLimit(1)
                        Text("\(self.noteCellVM.date)")
                    }
                }
            }
            NavigationLink(destination: NoteDetailView(noteCellVM: noteCellVM)) {
                EmptyView()
            }
        }
    }

}



