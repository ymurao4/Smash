//
//  NoteRepository.swift
//  Smash
//
//  Created by 村尾慶伸 on 2020/07/27.
//  Copyright © 2020 村尾慶伸. All rights reserved.
//

import Foundation
import SwiftUI
import Firebase
import FirebaseFirestoreSwift
import FirebaseFirestore
import FirebaseStorage
import FirebaseAuth

class NoteRepository: ObservableObject {

    let db = Firestore.firestore()
    let storage = Storage.storage()
    let userId = Auth.auth().currentUser?.uid

    @Published var notes: [Note] = []

    init() {
        loadDate()
    }

    func loadDate() {

        db.collection("notes")
            .order(by: "createdTime", descending: true)
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

    // images methods

    func uploadImage(image: UIImage) -> String {
        
        guard let userId = userId else { return "" }
        let data = image.jpegData(compressionQuality: 0.01)! as Data
        let imageName = NSUUID().uuidString
        let outputData = imageName + ".jpg"

        let imageRef = storage.reference(forURL: "gs://smash-80661.appspot.com").child("\(userId)").child("\(imageName).jpg")
        let meta = StorageMetadata()
        meta.contentType = "image/jpeg"


        let uploadTask = imageRef.putData(data, metadata: meta) { (metadata, error) in

            if error != nil {

                print(error!.localizedDescription)
                return
            }
        }
        self.observeUploadTaskFailureCases(uploadTask: uploadTask)


        return "\(outputData)"
    }

    func observeUploadTaskFailureCases(uploadTask : StorageUploadTask) {

        uploadTask.observe(.failure) { snapshot in

            if let error = snapshot.error as NSError? {

                switch (StorageErrorCode(rawValue: error.code)!) {

                case .objectNotFound:
                    NSLog("File doesn't exist")
                    break
                case .unauthorized:
                    NSLog("User doesn't have permission to access file")
                    break
                case .cancelled:
                    NSLog("User canceled the upload")
                    break

                case .unknown:
                    NSLog("Unknown error occurred, inspect the server response")
                    break
                default:
                    NSLog("A separate error occurred, This is a good place to retry the upload.")
                    break
                }
            }
        }
    }

    func deleteImage(urls: [String]?) {
        guard let urls = urls else { return }
        for url in urls {
            let deleteRef = storage.reference(forURL: "gs://smash-80661.appspot.com").child(userId!).child(url)
            deleteRef.delete { (error) in
                if let error = error {
                    print(error)
                } else {
                    print("Image successfully deleted")
                }
            }
        }

    }
}


// fetch image data from firebase storage
extension UIImage {
    static func contentOfFIRStorage(path: String?, callback: @escaping (UIImage?, String) -> Void) {
        guard let path = path else { return }

        let storage = Storage.storage()
        let host = "gs://smash-80661.appspot.com"
        let userId = Auth.auth().currentUser?.uid

        storage.reference(forURL: host).child(userId!).child(path)
            .getData(maxSize: 1 * 1024 * 1024) { (data, error) in
                if error != nil {
                    callback(nil, "")
                    return
                }
                if let data = data {
                    let image = UIImage(data: data)
                    callback(image, path)
                }
        }
    }
}
