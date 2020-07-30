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

    @Published var repository = FrameRepository()
    @Published var frameDatas = [Frame]()
    @Published var fighterName = "mario"

    private var cancellables = Set<AnyCancellable>()

    init() {
        repository.$results.map { results in
            results.map { result in
                guard result[0] != "" else {
                    return Frame(name: "", frameStartup: "", totalFrames: "", onShield: "", activeOn: "")
                }
            return  Frame(name: result[1], frameStartup: result[2], totalFrames: result[3], onShield: result[4], activeOn: result[5])
            }
        }
        .assign(to: \.frameDatas, on: self)
        .store(in: &cancellables)
    }

    func loadFrameData(fighterName: String) {
        DispatchQueue.main.async {
            self.fighterName = fighterName
            self.repository.loadData(fighterName: fighterName)
        }
    }

}
