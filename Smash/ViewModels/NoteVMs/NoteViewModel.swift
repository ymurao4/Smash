//
//  NoteViewModel.swift
//  Smash
//
//  Created by 村尾慶伸 on 2020/07/25.
//  Copyright © 2020 村尾慶伸. All rights reserved.
//

import Foundation
import Combine

class NoteViewModel: ObservableObject {

    @Published var noteRepository = NoteRepository()
    @Published var noteCellViewModels = [NoteCellViewModel]()

    private var cancellables = Set<AnyCancellable>()

    init() {
        noteRepository.$notes.map { notes in
            notes.map { note in
                NoteCellViewModel(note: note)
            }
        }
        .assign(to: \.noteCellViewModels, on: self)
        .store(in: &cancellables)
    }

    func addNote(note: Note) {
        noteRepository.addNote(note: note)
    }

    func deleteNote(noteID: String?) {
        if let noteID = noteID {
            noteRepository.deleteNote(noteID: noteID)
        }
    }


}
