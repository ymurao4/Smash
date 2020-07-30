//
//  AddRecordView.swift
//  Smash
//
//  Created by 村尾慶伸 on 2020/07/21.
//  Copyright © 2020 村尾慶伸. All rights reserved.
//

import SwiftUI
import WaterfallGrid

struct AddRecordView: View {

    @ObservedObject var recordListVM = RecordListViewMdoel()

    @Environment(\.presentationMode) var presentatinoMode
    @State private var selectedIndex: Int = 0
    @State private var myFighterName: String = "mario"
    @State private var opponentFighterName: String = "mario"
    @State private var stageName: String = "syuten"
    @State private var result: Bool = true

    private let pickerNames = ["自分", "相手", "ステージ"]
    
    var stringResult = { (result: Bool) -> String in
        if result {
            return "win"
        } else {
            return "lose"
        }
    }
    
    var body: some View {
        NavigationView {
            VStack {
                FormCell(myFighterName: $myFighterName, opponentFighterName: $opponentFighterName, stageName: $stageName, result: $result, selectedIndex: $selectedIndex)
                Spacer()
                    .frame(height: 20)
                Picker("", selection: $selectedIndex) {
                    ForEach(0..<self.pickerNames.count) { index in
                        Text(self.pickerNames[index])
                            .tag(index)
                    }
                }
                .pickerStyle(SegmentedPickerStyle())

                if selectedIndex == 0 {
                    MyFighterView(fighterName: $myFighterName)
                } else if selectedIndex == 1 {
                    OpponentFighterView(opponentFighterName: $opponentFighterName)
                } else if selectedIndex == 2 {
                    StageView(stageName: $stageName)
                }

                Spacer()
            }
            .padding(20)
            .navigationBarTitle("対戦結果")
            .navigationBarItems(
                leading:
                Button(action: {
                    self.presentatinoMode.wrappedValue.dismiss()
                }) {
                    Text("Cancel")
                        .foregroundColor(.orange)
                },
                trailing:
                Button(action: {
                    self.recordListVM.addRecord(record: Record(result: self.stringResult(self.result), myFighter: self.myFighterName, opponentFighter: self.opponentFighterName, stage: self.stageName))
                    self.presentatinoMode.wrappedValue.dismiss()
                }) {
                    Text("Done")
                        .foregroundColor(.orange)
                }
            )
        }
    }

}


#if DEBUG
struct AddRecordView_Previews: PreviewProvider {
    static var previews: some View {
        AddRecordView()
    }
}
#endif


struct FormCell: View {

    @Binding var myFighterName: String
    @Binding var opponentFighterName: String
    @Binding var stageName: String
    @Binding var result: Bool
    @Binding var selectedIndex: Int

    var body: some View {
        HStack(alignment: .top, spacing: 20) {
            VStack {
                Text("勝敗")
                    .padding(.bottom, 30)
                HStack {
                    Button(action: { self.result.toggle() }) {
                        Text("Win")
                            .font(.subheadline)
                    }
                    .frame(width: 40, height: 30)
                    .background(result ? Color.orange : nil)
                    .foregroundColor(result ? .white : Color.primary)
                    .cornerRadius(5)
                    .padding(.trailing, 7)

                    Button(action: { self.result.toggle() }) {
                        Text("Lose")
                            .font(.subheadline)
                    }
                    .frame(width: 40, height: 30)
                    .background(!result ? Color.orange : nil)
                    .foregroundColor(!result ? .white : Color.primary)
                    .cornerRadius(5)
                }
            }
            VStack {
                Text("自分")

                Button(action: {
                    self.selectedIndex = 0
                }) {
                    FighterPDF(name: myFighterName)
                        .frame(width: 50, height: 50)
                        .background(Color.orange)
                        .cornerRadius(25)
                }
            }
            VStack {
                Text("相手")
                Button(action: {
                    self.selectedIndex = 1
                }) {
                    FighterPDF(name: opponentFighterName)
                        .frame(width: 50, height: 50)
                        .background(Color.accentColor)
                        .cornerRadius(25)
                }
            }
            VStack {
                Text("ステージ")
                    .padding(.bottom, 8)
                Button(action: {
                    self.selectedIndex = 2
                }) {
                    StagePDF(name: stageName)
                        .frame(width: 60, height: 40)
                        .cornerRadius(3)
                }
            }

        }
    }

}


// waterFallGrid
struct MyFighterView: View {

    @Binding var fighterName: String

    var body: some View {
        WaterfallGrid((0..<S.fightersArray.count), id: \.self) { index in
            Button(action: {
                self.fighterName = S.fightersArray[index][1]
            }) {
                FighterPDF(name: S.fightersArray[index][1])
                    .frame(width: 40, height: 40)
                    .background(Color.orange)
                    .cornerRadius(20)
            }
        }
        .gridStyle(
            columns: 6,
            spacing: 5,
            animation: .easeInOut(duration: 0.5)
        )
            .scrollOptions(
                direction: .vertical,
                showsIndicators: false
        )
    }
}

struct OpponentFighterView: View {

    @Binding var opponentFighterName: String

    var body: some View {
        WaterfallGrid((0..<S.fightersArray.count), id: \.self) { index in
            Button(action: {
                self.opponentFighterName = S.fightersArray[index][1]
            }) {
                FighterPDF(name: S.fightersArray[index][1])
                    .frame(width: 40, height: 40)
                    .background(Color.accentColor)
                    .cornerRadius(20)
            }
        }
        .gridStyle(
            columns: 6,
            spacing: 5,
            animation: .easeInOut(duration: 0.5)
        )
            .scrollOptions(
                direction: .vertical,
                showsIndicators: false
        )
    }
}

struct StageView: View {

    @Binding var stageName: String

    var body: some View {
        WaterfallGrid((0..<S.stageArray.count), id: \.self) { index in
            VStack(spacing: 0) {
                Button(action: {
                    self.stageName = S.stageArray[index][1]
                }) {
                    StagePDF(name: S.stageArray[index][1])
                        .frame(width: 100, height: 80)
                        .cornerRadius(10)
                }
                Text(S.stageArray[index][0])
                    .font(.footnote)
            }
        }
        .gridStyle(
            columns: 3,
            spacing: 10,
            animation: .easeInOut(duration: 0.5))
    }
}


