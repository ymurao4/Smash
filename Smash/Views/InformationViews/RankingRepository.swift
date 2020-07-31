//
//  RankingRepository.swift
//  Smash
//
//  Created by 村尾慶伸 on 2020/07/31.
//  Copyright © 2020 村尾慶伸. All rights reserved.
//

import Foundation

class RankingRepository: ObservableObject {

    @Published var rankingResults: [[String]] = []

    func loadData(rankingName: String) {

        rankingResults = []

        guard let path = Bundle.main.path(forResource: "csv/Ranking/\(rankingName)", ofType: "csv") else {

            return
        }

        do {
            let csvString = try String(contentsOfFile: path, encoding: String.Encoding.utf8)

            let rows = csvString.components(separatedBy: .newlines)

            for row in rows {
                let columns = row.components(separatedBy: ",")
                if columns[0] != "" {
                    rankingResults.append(columns)
                }
            }
        } catch {
            print("Error loading csv file: \(error.localizedDescription)")
        }

    }
}
