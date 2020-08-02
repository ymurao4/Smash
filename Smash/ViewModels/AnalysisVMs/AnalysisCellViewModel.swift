//
//  AnalysisCellViewModel.swift
//  Smash
//
//  Created by 村尾慶伸 on 2020/08/02.
//  Copyright © 2020 村尾慶伸. All rights reserved.
//

import Foundation
import Combine

class AnalysisCellViewModel: ObservableObject, Identifiable {

    @Published var record: Record

    var id: String = ""
    private var cancellables = Set<AnyCancellable>()


    init(record: Record) {
        self.record = record

        $record
            .compactMap { record in
                record.id
        }
        .assign(to: \.id, on: self)
        .store(in: &cancellables)

    }

}


