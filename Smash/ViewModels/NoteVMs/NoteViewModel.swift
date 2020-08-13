//
//  NoteViewModel.swift
//  Smash
//
//  Created by 村尾慶伸 on 2020/07/25.
//  Copyright © 2020 村尾慶伸. All rights reserved.
//

import Foundation
import Combine
import SwiftUI
import FirebaseStorage

class NoteViewModel: ObservableObject {

    @Published var noteRepository = NoteRepository()
    @Published var noteCellViewModels = [NoteCellViewModel]()

    private var cancellables = Set<AnyCancellable>()

    init() {
        noteRepository.$notes.map { notes in
            notes.map { note in
                return NoteCellViewModel(note: note)
            }
        }
        .assign(to: \.noteCellViewModels, on: self)
        .store(in: &cancellables)
    }

    func addNote(note: Note) {
        if note.text == "" && note.imageURL == "" {
            return
        }
        noteRepository.addNote(note: note)
    }

    func deleteNote(noteID: String?) {
        if let noteID = noteID {
            noteRepository.deleteNote(noteID: noteID)
        }
    }

    func deleteEmptyNote(noteCell: NoteCellViewModel) {
        if noteCell.note.text == "" && noteCell.note.imageURL == "" {
            if let id = noteCell.note.id {
                self.noteRepository.deleteNote(noteID: id)
            }
        }
    }

    func uploadImage(image: UIImage) -> String {
        let url = noteRepository.uploadImage(image: image)
        return url
    }


}
