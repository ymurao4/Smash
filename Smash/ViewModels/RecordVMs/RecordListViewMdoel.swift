//
//  RecordViewModel.swift
//  Smash
//
//  Created by 村尾慶伸 on 2020/07/21.
//  Copyright © 2020 村尾慶伸. All rights reserved.
//

import Foundation
import Combine

class RecordListViewMdoel: ObservableObject {

    @Published var recordRepository = RecordRepository()
    @Published var recordCellViewModels = [RecordCelViewModel]()

    private var cancellables = Set<AnyCancellable>()

    init() {
        recordRepository.$records.map { records in
            records.map { record in
                RecordCelViewModel(record: record)
            }
        }
        .assign(to: \.recordCellViewModels, on: self)
        .store(in: &cancellables)

    }

    func addRecord(record: Record) {
        recordRepository.addRecord(record: record)
    }

    func deleteRecord(recordID: String?) {
        if let recordID = recordID {
            recordRepository.deleteRecord(recordID: recordID)
        }
    }

}
