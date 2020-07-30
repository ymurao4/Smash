//
//  RecordVIew.swift
//  Smash
//
//  Created by 村尾慶伸 on 2020/07/20.
//  Copyright © 2020 村尾慶伸. All rights reserved.

import SwiftUI

struct RecordView: View {

    @ObservedObject var recordListVM = RecordListViewMdoel()
    @State private var isSheet: Bool = false
    @State private var isAlert: Bool = false
    @State private var recordID: String?

    private func showDeleteAlert(index: IndexSet) {
        isAlert.toggle()
        self.recordID = self.recordListVM.recordCellViewModels[index.first!].id
    }

    var body: some View {
        NavigationView{
            List{
                ForEach(recordListVM.recordCellViewModels) { recordCellVM in
                    ResultCell(recordCellVM: recordCellVM)
                }
                .onDelete(perform: showDeleteAlert)
                .alert(isPresented: $isAlert) {
                    Alert(
                        title: Text("本当に削除しますか？"),
                        message: Text("この対戦記録を削除します。"),
                        primaryButton: .default(Text("削除"),
                                                action: {
                                                    self.recordListVM.deleteRecord(recordID: self.recordID)
                        }),
                        secondaryButton: .cancel(Text("キャンセル"))
                    )
                }
                // tabbarで隠れてしまうため
                Text("")
            }
            .navigationBarTitle("対戦記録")
            .navigationBarItems(trailing:
                Button(action: {
                    self.isSheet.toggle()
                }) {
                    Image(systemName: "plus")
                        .resizable()
                        .frame(width: 20, height: 20)
                }
            )
        }
        .sheet(isPresented: $isSheet) {
            AddRecordView()
        }
    }
}

struct RecordVIew_Previews: PreviewProvider {
    static var previews: some View {
        RecordView()
    }
}


struct ResultCell: View {

    @ObservedObject var recordCellVM: RecordCelViewModel

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
        case "lylat":
            return "ライ"
        default:
            return ""
        }
    }

    var borderColor = { (record: Record) -> Color in
        if record.result == "win" {
            return .orange
        } else {
            return .blue
        }
    }

    var body: some View {
        HStack(spacing: 30) {
            VStack(alignment: .center, spacing: 5) {
                Text(recordCellVM.record.result)
                EdgeBorder(width: 5, edge: .top)
                    .foregroundColor(self.borderColor(recordCellVM.record))
                    .frame(maxWidth: .infinity)
            }
            FighterPDF(name: recordCellVM.record.myFighter)
                .frame(width: 40, height: 40)
            Text("vs")
                .font(.headline)
            FighterPDF(name: recordCellVM.record.opponentFighter)
                .frame(width: 40, height: 40)
            VStack(spacing: 0) {
                StagePDF(name: recordCellVM.record.stage)
                    .frame(width: 60, height: 30)
                    .cornerRadius(3)
                Text(self.stageName(recordCellVM.record.stage))
                    .font(.caption)
            }
        }
        .padding(EdgeInsets(top: 0, leading: 10, bottom: 0, trailing: 10))
    }
}
