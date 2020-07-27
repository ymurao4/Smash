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

    @Published var recordCellViewModels = [RecordCelViewModel]()

    private var cancellables = Set<AnyCancellable>()

    init() {
        self.recordCellViewModels = testDatas.map { record in
            RecordCelViewModel(record: record)
        }
    }

    func addRecord(record: Record) {
        let recordCellVM = RecordCelViewModel(record: record)
        self.recordCellViewModels.append(recordCellVM)
    }

}
