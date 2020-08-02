//
//  FIrebaseReposiroty.swift
//  Smash
//
//  Created by 村尾慶伸 on 2020/07/27.
//  Copyright © 2020 村尾慶伸. All rights reserved.
//

import Foundation
import Firebase
import FirebaseFirestoreSwift
import FirebaseFirestore
import FirebaseAuth

class RecordRepository: ObservableObject {

    let db = Firestore.firestore()

    @Published var records = [Record]()

    init() {
        loadData()
    }

    func loadData() {

        let userId = Auth.auth().currentUser?.uid

        db.collection("records")
            .order(by: "createdTime", descending: true)
            .whereField("userId", isEqualTo: userId as Any)
            .addSnapshotListener { (querySnapshot, error) in
                if let querySnapshot = querySnapshot {
                    DispatchQueue.main.async {
                        self.records = querySnapshot.documents.compactMap { document in
                            do {
                                let x = try document.data(as: Record.self)
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

    func addRecord(record: Record) {
        do {
            var addedRecord = record
            addedRecord.userId = Auth.auth().currentUser?.uid
            let _ = try db.collection("records").addDocument(from: addedRecord)
        } catch {
            fatalError("Unable to encode record: \(error)")
        }
    }

    func deleteRecord(recordID: String) {
        db.collection("records").document(recordID).delete() { error in
            if let error = error {
                print("Error removing document: \(error.localizedDescription)")
            } else {
                print("Document successfully deleted!")
            }
        }
    }

}
