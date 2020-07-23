//
//  Repository.swift
//  Smash
//
//  Created by 村尾慶伸 on 2020/07/23.
//  Copyright © 2020 村尾慶伸. All rights reserved.
//

import Foundation

class Repository: ObservableObject {

    @Published var results: [[String]] = []
    @Published var fighterName: String = "mario"

    init() {
        loadData(fighterName: fighterName)
    }

    func loadData(fighterName: String) {
        
        results = []

        guard let path = Bundle.main.path(forResource: "csv/\(fighterName)", ofType: "csv") else {
            return
        }

        do {
            let csvString = try String(contentsOfFile: path, encoding: String.Encoding.utf8)

            let rows = csvString.components(separatedBy: .newlines)
            for row in rows {
                let columns = row.components(separatedBy: ",")
                results.append(columns)
            }

        } catch {
            print("Error loadgin csv file: \(error.localizedDescription)")
        }

        results.removeFirst()
        results.removeLast()

    }
}
