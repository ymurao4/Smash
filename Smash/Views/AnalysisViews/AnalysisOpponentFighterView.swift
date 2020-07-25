//
//  AnalysisOpponentFighterView.swift
//  Smash
//
//  Created by 村尾慶伸 on 2020/07/25.
//  Copyright © 2020 村尾慶伸. All rights reserved.
//

import SwiftUI

struct AnalysisOpponentFighterView: View {
    var body: some View {
        List {
            ForEach(0..<S.fightersArray.count) { index in
                HStack() {
                    FighterPDF(name: S.fightersArray[index][1])
                        .frame(width: 25, height: 25)
                        .frame(maxWidth: .infinity)
                    Text("5")
                        .frame(maxWidth: .infinity)
                    Text("3")
                        .frame(maxWidth: .infinity)
                    Text("2")
                        .frame(maxWidth: .infinity)
                    Text("60.0%")
                        .lineLimit(1)
                        .minimumScaleFactor(0.2)
                        .frame(maxWidth: .infinity)
                }
            }
        }
    }
}

struct AnalysisOpponentFighterView_Previews: PreviewProvider {
    static var previews: some View {
        AnalysisOpponentFighterView()
    }
}
