//
//  Frame.swift
//  Smash
//
//  Created by 村尾慶伸 on 2020/07/22.
//  Copyright © 2020 村尾慶伸. All rights reserved.
//

import Foundation

struct Frame: Identifiable {
    var id: String = UUID().uuidString
    var name: String
    var frameStartup: String
    var totalFrames: String
    var onShield: String
    var activeOn: String
}

