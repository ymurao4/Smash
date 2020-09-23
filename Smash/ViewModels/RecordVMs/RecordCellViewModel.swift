//
//  RecordCellViewModel.swift
//  Smash
//
//  Created by 村尾慶伸 on 2020/07/22.
//  Copyright © 2020 村尾慶伸. All rights reserved.
//

import Foundation
import Combine

class RecordCelViewModel: ObservableObject, Identifiable {

    @Published var record: Record
    var id: String = ""
    @Published var date: String = ""

    private var cancellables = Set<AnyCancellable>()

    init(record: Record) {
        self.record = record

        $record
            .compactMap { record in

                guard let timestamp = record.createdTime else { return "" }

                let dateValue = timestamp.dateValue()

                let dateFormatter = DateFormatter()
                dateFormatter.locale = Locale(identifier: "ja_JP")
                dateFormatter.dateStyle = .medium
                dateFormatter.timeStyle = .none
                let date = dateFormatter.string(from: dateValue)
                return date
            }
            .assign(to: \.date, on: self)
            .store(in: &cancellables)

        $record
            .compactMap { record in
                record.id
        }
        .assign(to: \.id, on: self)
        .store(in: &cancellables)
    }

}
