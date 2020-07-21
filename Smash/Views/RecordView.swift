//
//  RecordVIew.swift
//  Smash
//
//  Created by 村尾慶伸 on 2020/07/20.
//  Copyright © 2020 村尾慶伸. All rights reserved.
//

import SwiftUI

struct RecordView: View {

    let testData = testDatas

    var body: some View {
        NavigationView{
            List{
                ForEach(testData) { data in
                    ResultCell(data: data)
                }
            }
            .navigationBarTitle("Record")
        }
    }
}

struct RecordVIew_Previews: PreviewProvider {
    static var previews: some View {
        RecordView()
    }
}

struct ResultCell: View {

    let data: Record

     var stageName = { (name: String) -> String in
        switch name {
        case "syuten":
            return "終点"
        case "senjou":
            return "戦場"
        case "pokesuta2":
            return "ポケ2"
        case "karosu":
            return "カロス"
        case "sumamura":
            return "スマ村"
        case "muramati":
            return "村と街"
        default:
            return ""
        }
    }

    var borderColor = { (data: Record) -> Color in
        if data.result == "win" {
            return .orange
        } else {
            return .blue
        }
    }

    var body: some View {
        HStack(spacing: 30) {
            VStack(alignment: .center, spacing: 5) {
                Text(data.result)
                EdgeBorder(width: 5, edge: .top)
                    .foregroundColor(self.borderColor(data))
                    .frame(maxWidth: .infinity)
            }
            FighterPDF(name: data.myFighter)
                .frame(width: 40, height: 40)
            Text("vs")
                .font(.headline)
            FighterPDF(name: data.opponentFighter)
                .frame(width: 40, height: 40)
            VStack(spacing: 0) {
                StagePDF(name: data.stage)
                    .frame(width: 60, height: 30)
                    .cornerRadius(3)
                Text(self.stageName(data.stage))
                    .font(.caption)
            }
        }
        .padding(EdgeInsets(top: 0, leading: 10, bottom: 0, trailing: 10))
    }
}
