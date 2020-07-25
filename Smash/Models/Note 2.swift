//
//  Note.swift
//  Smash
//
//  Created by 村尾慶伸 on 2020/07/25.
//  Copyright © 2020 村尾慶伸. All rights reserved.
//

import Foundation

struct Note: Identifiable {
    var id: String = UUID().uuidString
    var text: String
    var fighter: String
}


#if DEBUG
let testNotes = [
    Note(text: "掴み警戒", fighter: "mario"),
    Note(text: "ドキドキ空後チャレンジ", fighter: "wario"),
    Note(text: "", fighter: "lucario"),
    Note(text: "", fighter: "minmin"),
    Note(text: "", fighter: "joker"),
    Note(text: "", fighter: "kirby"),
    Note(text: "", fighter: "sonic"),
    Note(text: "", fighter: "samus")
]
#endif
