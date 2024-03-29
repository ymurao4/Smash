//
//  AnalysisMainViews.swift
//  Smash
//
//  Created by 村尾慶伸 on 2020/07/25.
//  Copyright © 2020 村尾慶伸. All rights reserved.
//

import SwiftUI

struct AnalysisMainFighterView: View {

    @ObservedObject var analysisVM = AnalysisViewModel(sortName: "opponentFighter")

    init() {
        
        analysisVM.isMain = true
    }

    var body: some View {

        List {

            HStack {

                ForEach(analysisVM.totalRecord, id: \.self) { item in

                    HStack {

                        Text(item.localized)
                            .frame(maxWidth: .infinity)
                    }
                }
            }

            ForEach(analysisVM.outputRecord, id: \.self) { array in

                HStack {

                    FighterPDF(name: array[0])
                        .frame(width: 25, height: 25)
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
        }
    }
}

