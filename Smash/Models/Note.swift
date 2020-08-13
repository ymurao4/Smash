//
//  Note.swift
//  Smash
//
//  Created by 村尾慶伸 on 2020/07/25.
//  Copyright © 2020 村尾慶伸. All rights reserved.
//

import Foundation
import FirebaseFirestore
import FirebaseFirestoreSwift

struct Note: Codable, Identifiable {
    @DocumentID var id: String?
    var text: String
    var fighterName: String?
    var imageURL: String?
    @ServerTimestamp var createdTime: Timestamp?
    var userId: String?
}


#if DEBUG
let testNotes = [
    Note(text: "掴み警戒", fighterName: "mario"),
    Note(text: "ドキドキ空後チャレンジ", fighterName: "wario"),
    Note(text: "", fighterName: "lucario"),
    Note(text: "大乱闘強い\njfos", fighterName: "minmin"),
    Note(text: "", fighterName: "joker"),
    Note(text: "", fighterName: "kirby"),
    Note(text: "", fighterName: "sonic"),
    Note(text: "", fighterName: "samus")
]
#endif
