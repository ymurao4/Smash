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

    @Published var frameRepository = FrameRepository()
    @Published var frameData = [Frame]()

    private var cancellables = Set<AnyCancellable>()

    init() {
        frameRepository.$frameResults.map { results in
            
            results.map { result in
                return  Frame(name: result[1], frameStartup: result[2], totalFrames: result[3], onShield: result[4], activeOn: result[5])
            }
        }
        .assign(to: \.frameData, on: self)
        .store(in: &cancellables)
    }

    func loadFrameData(fighterName: String) {
        DispatchQueue.main.async {
            self.frameRepository.loadData(fighterName: fighterName)
        }
    }

}
