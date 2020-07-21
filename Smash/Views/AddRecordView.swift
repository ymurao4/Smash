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

    @Environment(\.presentationMode) var presentatinoMode
    @State var result: Bool = true
    @State var isMyFighterView: Bool = false
    @State var isOpponentFighterView: Bool = false
    @State var isStagViwe: Bool = false
    @State var myFighterName: String = "mario"
    @State var opponentFighterName: String = "mario"
    @State var stageName: String = "syuten"

    
    var body: some View {
        NavigationView {
            VStack {
                FormCell(myFighterName: $myFighterName, opponentFighterName: $opponentFighterName, stageName: $stageName, result: $result, isMyFighterView: $isMyFighterView, isOpponentFighterView: $isOpponentFighterView, isStageView: $isStagViwe)
                if isMyFighterView {
                    MyFighterView(isMyFighterView: $isMyFighterView, fighterName: $myFighterName)
                }
                else if isOpponentFighterView {
                    OpponentFighterView(isOpponentFighterView: $isOpponentFighterView, opponentFighterName: $opponentFighterName)
                }
                else if isStagViwe {
                    StageView(isStageView: $isStagViwe, stageName: $stageName)
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
                },
                trailing:
                Button(action: {
                    self.presentatinoMode.wrappedValue.dismiss()
                }) {
                    Text("Done")
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
    @Binding var isMyFighterView: Bool
    @Binding var isOpponentFighterView: Bool
    @Binding var isStageView: Bool

    var body: some View {
        VStack(spacing: 20) {
            HStack {
                Text("自分")
                Spacer()
                Button(action: {
                    self.isMyFighterView.toggle()
                    // 他のViewをfalseに
                    if self.isOpponentFighterView || self.isStageView {
                        self.isOpponentFighterView = false
                        self.isStageView = false
                    }
                }) {
                    FighterPDF(name: myFighterName)
                        .frame(width: 50, height: 50)
                }
                .background(Color.orange)
                .border(Color.orange, width: 2)
                .cornerRadius(25)
            }
            HStack {
                Text("相手")
                Spacer()
                Button(action: {
                    self.isOpponentFighterView.toggle()
                    // 他のViewをfalseに
                    if self.isMyFighterView || self.isStageView {
                        self.isMyFighterView = false
                        self.isStageView = false
                    }
                }) {
                    FighterPDF(name: opponentFighterName)
                        .frame(width: 50, height: 50)
                }
                .background(Color.accentColor)
                .border(Color.accentColor, width: 2)
                .cornerRadius(25)
            }
            HStack {
                Text("ステージ")
                Spacer()
                Button(action: {
                    self.isStageView.toggle()
                    // 他のViewをfalseに
                    if self.isMyFighterView || self.isOpponentFighterView {
                        self.isMyFighterView = false
                        self.isOpponentFighterView = false
                    }
                }) {
                    StagePDF(name: stageName)
                        .frame(width: 60, height: 40)
                        .cornerRadius(3)
                }
            }
            HStack {
                Text("勝敗")
                Spacer()
                Button(action: {
                    self.result.toggle()
                }) {
                    Text("Win").padding(7)
                }
                .background(result ? Color.accentColor : nil)
                .foregroundColor(Color(UIColor.label))
                .cornerRadius(7)
                Button(action: {
                    self.result.toggle()
                }) {
                    Text("lose").padding(7)
                }
                .background(!result ? Color.accentColor : nil)
                .foregroundColor(Color(UIColor.label))
                .cornerRadius(7)
            }
        }
    }

}

// waterFallGrid
struct MyFighterView: View {

    @Binding var isMyFighterView: Bool
    @Binding var fighterName: String

    var body: some View {
        WaterfallGrid((0..<S.fightersArray.count), id: \.self) { index in
            Button(action: {
                self.isMyFighterView = false
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

    @Binding var isOpponentFighterView: Bool
    @Binding var opponentFighterName: String

    var body: some View {
        WaterfallGrid((0..<S.fightersArray.count), id: \.self) { index in
            Button(action: {
                self.isOpponentFighterView = false
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

    @Binding var isStageView: Bool
    @Binding var stageName: String

    var body: some View {
        WaterfallGrid((0..<S.stageArray.count), id: \.self) { index in
            Button(action: {
                self.isStageView = false
                self.stageName = S.stageArray[index][1]
            }) {
                StagePDF(name: S.stageArray[index][1])
                .frame(width: 60, height: 40)
                .cornerRadius(3)
            }
        }
        .gridStyle(
            columns: 3,
            spacing: 10,
            animation: .easeInOut(duration: 0.5))
    }
}
