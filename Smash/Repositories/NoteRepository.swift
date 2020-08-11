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
import FirebaseStorage

class NoteRepository: ObservableObject {

    let userId = Auth.auth().currentUser?.uid

    let db = Firestore.firestore()
    let storage = Storage.storage().reference(forURL: "gs://smash-80661.appspot.com")

    @Published var notes = [Note]()

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

    func saveImages(imagesArray: [UIImage]) {

        guard let userId = userId else { return }
        uploadImages(userId: userId, imagesArray: imagesArray) { (uploadedImageUrlsArray) in
            print("uploadedImageUrlsArray: \(uploadedImageUrlsArray)")
        }

    }

    func uploadImages(userId: String, imagesArray: [UIImage], completionHandler: @escaping ([String]) -> ()) {
        let storage = Storage.storage()

        var uploadedImageUrlsArray = [String]()
        var uploadCount = 0
        let imagesCount = imagesArray.count

        for image in imagesArray {
            let imageName = NSUUID().uuidString // Unique string to reference

            let storageRef = storage.reference(forURL: "gs://smash-80661.appspot.com").child("\(userId)").child("\(imageName).png")

            guard let uploadData = image.pngData() else { return }

            let uploadTask = storageRef.putData(uploadData, metadata: nil) { (metaData, error) in
                if error != nil {
                    print(error as Any)
                    return
                }

                storageRef.downloadURL { (url, error) in
                    if let url = url {
                        let urlString = url.absoluteString
                        uploadedImageUrlsArray.append(urlString)
                    }

                    uploadCount += 1
                    print("Number of images successfully uploaded: \(uploadCount)")
                    if uploadCount == imagesCount {
                        NSLog("All Images are uploaded successfully, uploadedImageUrlsArray: \(uploadedImageUrlsArray)")
                        completionHandler(uploadedImageUrlsArray)
                    }
                }
            }

            observeUploadTaskFailureCases(uploadTask: uploadTask)

        }

    }

    func observeUploadTaskFailureCases(uploadTask : StorageUploadTask){
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

}

/*
 class UploadImages: NSObject{

// static func saveImages(imagesArray : [UiImage]){
//
//            Auth.auth().signInAnonymously() { (user, error) in
//                //let isAnonymous = user!.isAnonymous  // true
//                //let uid = user!.uid
//                if error != nil{
//                    print(error)
//                    return
//                }
//                guard let uid = user?.uid else{
//                    return
//                }
//
//                uploadImages(userId: uid,imagesArray : imagesArray){ (uploadedImageUrlsArray) in
//                    print("uploadedImageUrlsArray: \(uploadedImageUrlsArray)")
//                }
//            }
//        }


 static func uploadImages(userId: String, imagesArray : [UIImage], completionHandler: @escaping ([String]) -> ()){
        var storage     =   Storage.storage()

        var uploadedImageUrlsArray = [String]()
        var uploadCount = 0
        let imagesCount = imagesArray.count

        for image in imagesArray{

            let imageName = NSUUID().uuidString // Unique string to reference image

            //Create storage reference for image
            let storageRef = storage.reference().child("\(userId)").child("\(imageName).png")

            guard let uplodaData = image.pngData() else{
                return
            }

            // Upload image to firebase
            let uploadTask = storageRef.putData(uplodaData, metadata: nil, completion: { (metadata, error) in
                if error != nil{
                    print(error)
                    return
                }
                if let imageUrl = metadata?.downloadURL()?.absoluteString{
                    print(imageUrl)
                    uploadedImageUrlsArray.append(imageUrl)

                    uploadCount += 1
                    print("Number of images successfully uploaded: \(uploadCount)")
                    if uploadCount == imagesCount{
                        NSLog("All Images are uploaded successfully, uploadedImageUrlsArray: \(uploadedImageUrlsArray)")
                        completionHandler(uploadedImageUrlsArray)
                    }
                }

            })


            observeUploadTaskFailureCases(uploadTask : uploadTask)
        }
 }


 //Func to observe error cases while uploading image files, Ref: https://firebase.google.com/docs/storage/ios/upload-files

    static func observeUploadTaskFailureCases(uploadTask : StorageUploadTask){
        uploadTask.observe(.failure) { snapshot in
            if let error = snapshot.error as? NSError {
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

}

*/
