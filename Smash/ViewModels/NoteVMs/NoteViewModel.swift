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

        if note.text == "" && note.imageURL.count == 0 {

            return
        }
        noteRepository.addNote(note: note)
    }

    func deleteNote(note: Note) {

        if let noteID = note.id {

            noteRepository.deleteNote(noteID: noteID)
        }

        noteRepository.deleteImage(urls: note.imageURL)
    }

    func deleteEmptyNote(noteCell: NoteCellViewModel) {

        if noteCell.note.text == "" && noteCell.note.imageURL.count == 0 {

            if let id = noteCell.note.id {

                self.noteRepository.deleteNote(noteID: id)
            }
        }
    }

    func uploadImage(image: UIImage) -> String {

        let url = noteRepository.uploadImage(image: image)
        return url
    }

    func deleteImage(path: String, note: inout Note) {

        let pathArray = [path]
        noteRepository.deleteImage(urls: pathArray)
        for (i, url) in note.imageURL.enumerated() {

            if url == path {
                
                note.imageURL.remove(at: i)
                self.noteRepository.updateNote(note: note)
            }
        }
    }


}
