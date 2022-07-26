//
//  Record.swift
//  Smash
//
//  Created by 村尾慶伸 on 2020/07/21.
//  Copyright © 2020 村尾慶伸. All rights reserved.
//

import Foundation
import FirebaseFirestoreSwift
import FirebaseFirestore

struct Record: Codable, Identifiable {
    @DocumentID var id: String?
    var result: String
    var myFighter: String
    var opponentFighter: String
    var stage: String
    @ServerTimestamp var createdTime: Timestamp?
    var userId: String?
    var whoFightWith: String = "Online"
}


#if DEBUG
let testDatas = [
    Record(result: "win", myFighter: "mario", opponentFighter: "minmin", stage: "senjou", whoFightWith: "online"),
    Record(result: "lose", myFighter: "wario", opponentFighter: "joker", stage: "syuten", whoFightWith: "online"),
    Record(result: "win", myFighter: "dedede", opponentFighter: "wario", stage: "syuten", whoFightWith: "online"),
    Record(result: "win", myFighter: "wario", opponentFighter: "purin", stage: "sumamura", whoFightWith: "online")
]
#endif


