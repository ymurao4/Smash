//
//  FrameCellViewModel.swift
//  Smash
//
//  Created by 村尾慶伸 on 2020/07/23.
//  Copyright © 2020 村尾慶伸. All rights reserved.
//

import Foundation
import Combine

class FrameCellViewModel: ObservableObject, Identifiable {

    @Published var frame: Frame
    var id: String = ""

     private var cancellabels = Set<AnyCancellable>()

    init(frame: Frame) {
        self.frame = frame

        $frame
            .compactMap { frame in
                frame.id
        }
        .assign(to: \.id, on: self)
        .store(in: &cancellabels)
    }

}
