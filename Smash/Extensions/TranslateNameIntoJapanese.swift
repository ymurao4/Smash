//
//  TranslateNameIntoJapanese.swift
//  Smash
//
//  Created by 村尾慶伸 on 2020/08/04.
//  Copyright © 2020 村尾慶伸. All rights reserved.
//

import Foundation

struct T {

    static func translateStageName(name: String) -> String {
        switch name {
        case "syuten":
            return "終点"
        case "senjou":
            return "戦場"
        case "pokesuta2":
            return "ポケ2"
        case "karosu":
            return "カロス"
        case "sumamura":
            return "スマ村"
        case "muramati":
            return "村と街"
        case "lylat":
            return "ライ"
        default:
            return ""
        }
    }

}

/*
 var stageName = { (name: String) -> String in
        switch name {
        case "syuten":
            return "終点"
        case "senjou":
            return "戦場"
        case "pokesuta2":
            return "ポケ2"
        case "karosu":
            return "カロス"
        case "sumamura":
            return "スマ村"
        case "muramati":
            return "村と街"
        case "lylat":
            return "ライ"
        default:
            return ""
        }
    }
 */
