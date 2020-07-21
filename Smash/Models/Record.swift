//
//  Record.swift
//  Smash
//
//  Created by 村尾慶伸 on 2020/07/21.
//  Copyright © 2020 村尾慶伸. All rights reserved.
//

import Foundation

struct Record: Identifiable {
    var id: String = UUID().uuidString
    var result: String
    var myFighter: String
    var opponentFighter: String
    var stage: String
}


#if DEBUG
let testDatas = [
    Record(result: "win", myFighter: "mario", opponentFighter: "minmin", stage: "senjou"),
    Record(result: "lose", myFighter: "wario", opponentFighter: "joker", stage: "syuten"),
    Record(result: "win", myFighter: "dedede", opponentFighter: "wario", stage: "syuten"),
    Record(result: "tie", myFighter: "wario", opponentFighter: "purin", stage: "sumamura"),
    Record(result: "win", myFighter: "wario", opponentFighter: "kamui", stage: "pokesuta")
]
#endif
