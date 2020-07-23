//
//  FrameViewModel.swift
//  Smash
//
//  Created by 村尾慶伸 on 2020/07/22.
//  Copyright © 2020 村尾慶伸. All rights reserved.
//

import Foundation
import Combine

class FrameViewModel: ObservableObject {

//    @Published var frame: Frame
//    @Published var fighterName: String = "wario"

    func loadData(name: String) -> [[String]]{

        var result: [[String]] = []

        guard let path = Bundle.main.path(forResource: "csv/\(name)", ofType: "csv") else {
            return result
        }

        do {
            let csvString = try String(contentsOfFile: path, encoding: String.Encoding.utf8)

            let rows = csvString.components(separatedBy: .newlines)
            for row in rows {
                let columns = row.components(separatedBy: ",")
                result.append(columns)
            }

        } catch {
            print("Error loadgin csv file: \(error.localizedDescription)")
        }


        result.remove(at: 0)
        return result
    }

}
