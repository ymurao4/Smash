//
//  RankingViewModel.swift
//  Smash
//
//  Created by 村尾慶伸 on 2020/07/31.
//  Copyright © 2020 村尾慶伸. All rights reserved.
//

import Foundation
import Combine

class RankingViewModel: ObservableObject {

    @Published var rankingRepository = RankingRepository()
    @Published var rankingData = [Ranking]()

    private var cancellables = Set<AnyCancellable>()

    init() {
        rankingRepository.$rankingResults.map { results in

            results.map { result in

                return Ranking(rank: result[1], fighterName: result[2], value: result[3])
            }
        }
        .assign(to: \.rankingData, on: self)
        .store(in: &cancellables)
    }

    func loadRankingData(rankingName: String) {
        
        DispatchQueue.main.async {
            self.rankingRepository.loadData(rankingName: rankingName)
        }
    }

}
