//
//  NoteRepository.swift
//  Smash
//
//  Created by 村尾慶伸 on 2020/07/27.
//  Copyright © 2020 村尾慶伸. All rights reserved.
//

import Foundation
import Firebase
import FirebaseFirestoreSwift
import FirebaseFirestore

class NoteRepository: ObservableObject {

    let db = Firestore.firestore()

    @Published var notes = [Note]()

    init() {
        loadDate()
    }

    func loadDate() {

        let userId = Auth.auth().currentUser?.uid

        db.collection("notes")
            .whereField("userId", isEqualTo: userId as Any)
            .addSnapshotListener { (querySnapshot, error) in
                DispatchQueue.main.async {
                    if let querySnapshot = querySnapshot {
                        self.notes = querySnapshot.documents.compactMap { document in
                            do {
                                let x = try document.data(as: Note.self)
                                return x
                            } catch {
                                print(error.localizedDescription)
                            }
                            return nil
                        }
                    }
                }
        }

    }

    func addNote(note: Note) {
        do {
            var addedNote = note
            addedNote.userId = Auth.auth().currentUser?.uid
            let _ = try db.collection("notes").addDocument(from: addedNote)
        } catch {
            fatalError("Unable to encode note: \(error)")
        }
    }

    func deleteNote(noteID: String) {
        db.collection("notes").document(noteID).delete() { error in
            if let error = error {
                print("Error removing note: \(error)")
            } else {
                print("Note successfully removed!")
            }
        }
    }

    func updateNote(note: Note) {
        if let noteID = note.id {
            do {
                try db.collection("notes").document(noteID).setData(from: note)
            } catch {
                fatalError("Unable to encode note: \(error)")
            }
        }
    }

}
