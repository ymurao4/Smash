//
//  Analysis.swift
//  Smash
//
//  Created by 村尾慶伸 on 2020/07/25.
//  Copyright © 2020 村尾慶伸. All rights reserved.
//

import Foundation

struct MainAnalysis: Identifiable {
    var id: String = UUID().uuidString
    var game: Int
    var win: Int
    var lose: Int
    var winRate: Int
}

struct AllMyFightersAnalysis: Identifiable {
    var id: String = UUID().uuidString
    var game: Int
    var win: Int
    var lose: Int
    var winRate: Int
}

struct AllOpponentFightersAnalysis: Identifiable {
    var id: String = UUID().uuidString
    var game: Int
    var win: Int
    var lose: Int
    var winRate: Int
}

struct AllStageAnalysis: Identifiable {
    var id: String = UUID().uuidString
    var game: Int
    var win: Int
    var lose: Int
    var winRate: Int
}
