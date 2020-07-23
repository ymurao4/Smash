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

    @Published var repository = Repository()
    @Published var frameCellViewModels = [FrameCellViewModel]()

    private var cancellables = Set<AnyCancellable>()

    init() {
        repository.$results.map { results in
            results.map { result in
                let frame = Frame(name: result[1], frameStartup: result[2], totalFrames: result[3], onShield: result[4], activeOn: result[5])
                return FrameCellViewModel(frame: frame)
            }
        }
        .assign(to: \.frameCellViewModels, on: self)
        .store(in: &cancellables)
    }


}
