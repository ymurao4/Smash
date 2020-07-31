//
//  Ranking.swift
//  Smash
//
//  Created by 村尾慶伸 on 2020/07/31.
//  Copyright © 2020 村尾慶伸. All rights reserved.
//

import Foundation

struct Ranking: Identifiable {
    var id: String = UUID().uuidString
    var rank: String
    var fighterName: String
    var value: String
}
