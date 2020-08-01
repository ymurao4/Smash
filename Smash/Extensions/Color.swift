//
//  Color.swift
//  Smash
//
//  Created by 村尾慶伸 on 2020/08/01.
//  Copyright © 2020 村尾慶伸. All rights reserved.
//

import Foundation
import SwiftUI

extension Color {
    static let black = Color.black
    static let white = Color.white

    static func backgroundColor(for colorScheme: ColorScheme) -> Color {
        if colorScheme == .dark {
            return white
        } else {
            return black
        }
    }

    static func reverseBackgroundColor(for colorScheme: ColorScheme) -> Color {
        if colorScheme == .dark {
            return black
        } else {
            return white
        }
    }
}
