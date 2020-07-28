//
//  NoteCellViewModels.swift
//  Smash
//
//  Created by 村尾慶伸 on 2020/07/25.
//  Copyright © 2020 村尾慶伸. All rights reserved.
//

import Foundation
import Combine

class NoteCellViewModel: ObservableObject, Identifiable {

    @Published var note: Note
    var id: String = ""

    private var cancellables = Set<AnyCancellable>()

    init(note: Note) {
        self.note = note

        $note
            .compactMap { note in
                note.id
        }
        .assign(to: \.id, on: self)
        .store(in: &cancellables)

    }

}

