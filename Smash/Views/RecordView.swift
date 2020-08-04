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
            VStack(alignment: .leading) {
                Button(action: {
                    self.isSheet.toggle()
                }) {
                    HStack {
                        Image(systemName: "plus.circle.fill")
                            .resizable()
                            .frame(width: 20, height: 20)
                        Text("記録を追加")
                    }
                }
                .padding(EdgeInsets(top: 10, leading: 20, bottom: 10, trailing: 20))
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
            }
            .padding(.horizontal, 10)
            .navigationBarTitle("対戦記録")
            .navigationBarItems(trailing: EditButton())
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
                Text(T.translateStageName(name: recordCellVM.record.stage))
                    .font(.caption)
            }
        }
    }
}
