//
//  AnalysisViewModel.swift
//  Smash
//
//  Created by 村尾慶伸 on 2020/07/25.
//  Copyright © 2020 村尾慶伸. All rights reserved.
//

import Foundation
import Combine

class AnalysisViewModel: ObservableObject {

    @Published var analysisRepository = AnalysisRepository()
    @Published var analysisCellViewModels = [AnalysisViewModel]()

    private var cancellables = Set<AnyCancellable>()

    init() {
        analysisRepository.$mainAnalyses.map { records in
            records.map { record in
                
            }
        }
    }
    

}
