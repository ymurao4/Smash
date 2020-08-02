//
//  AnalysisRepository.swift
//  Smash
//
//  Created by 村尾慶伸 on 2020/08/01.
//  Copyright © 2020 村尾慶伸. All rights reserved.
//

import Foundation
import Firebase
import FirebaseFirestoreSwift
import FirebaseFirestore
import FirebaseAuth

class AnalysisRepository: ObservableObject {

    let db = Firestore.firestore()
    @Published var mainAnalysisRecords = [MainAnalysis]()
    //    @Published var allMyFightersAnalysisRecords = [AllMyFightersAnalysis]()
    //    @Published var allOpponentFightersAnalysisRecords = [AllOpponentFightersAnalysis]()
    //    @Published var allStageAnalysisRecords = [AllStageAnalysis]()


    func loadData() {

        let userId = Auth.auth().currentUser?.uid

        db.collection("records")
            .order(by: "createdTime", descending: true)
            .whereField("userId", isEqualTo: userId as Any)
            .whereField("myFighter", isEqualTo: "wario")
            .addSnapshotListener { (querySnapshot, error) in
                if let querySnapshot = querySnapshot {
                    DispatchQueue.main.async {
                        self.mainAnalysisRecords = querySnapshot.documents.compactMap { document in
                            do {
                                let x = try document.data(as: MainAnalysis.self)
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


}
