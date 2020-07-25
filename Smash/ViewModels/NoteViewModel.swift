//
//  NoteViewModel.swift
//  Smash
//
//  Created by 村尾慶伸 on 2020/07/25.
//  Copyright © 2020 村尾慶伸. All rights reserved.
//

import Foundation
import Combine

class NoteViewModel: ObservableObject {

    @Published var noteCellViewModels = [NoteCellViewMdoel]()

    private var cancellables = Set<AnyCancellable>()

    init() {
        
    }

}
