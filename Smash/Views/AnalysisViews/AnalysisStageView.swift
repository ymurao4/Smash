//
//  AnalysisStageView.swift
//  Smash
//
//  Created by 村尾慶伸 on 2020/07/25.
//  Copyright © 2020 村尾慶伸. All rights reserved.
//

import SwiftUI

struct AnalysisStageView: View {

    @ObservedObject var analysisVM = AnalysisViewModel(sortName: "stage")

    var body: some View {
        List {
            ForEach(analysisVM.outputStageRecord, id: \.self) { array in
                HStack() {
                    VStack(spacing: 0) {
                        StagePDF(name: array[0])
                            .frame(width: 60, height: 30)
                            .cornerRadius(3)
                        Text(T.translateStageName(name: array[0]))
                            .font(.caption)
                    }
                    .frame(maxWidth: .infinity)
                    Text(array[1])
                        .frame(maxWidth: .infinity)
                    Text(array[2])
                        .frame(maxWidth: .infinity)
                    Text(array[3])
                        .frame(maxWidth: .infinity)
                    Text(array[4])
                        .lineLimit(1)
                        .minimumScaleFactor(0.2)
                        .frame(maxWidth: .infinity)
                }
            }
            // tabbarで隠れてしまうため
            Text("")
            Text("")
        }
    }
}

