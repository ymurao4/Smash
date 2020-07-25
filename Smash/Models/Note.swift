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
    var fighters: String
}


#if DEBUG
let testNotes = [
    Note(text: "", fighters: "mario"),
    Note(text: "", fighters: "wario")
]
#endif
