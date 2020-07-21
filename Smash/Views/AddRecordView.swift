//
//  AddRecordView.swift
//  Smash
//
//  Created by 村尾慶伸 on 2020/07/21.
//  Copyright © 2020 村尾慶伸. All rights reserved.
//

import SwiftUI

struct AddRecordView: View {

    @Environment(\.presentationMode) var presentatinoMode
    @State var result: Bool = true

    var body: some View {
        NavigationView {
            FormCell(result: $result)
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

struct AddRecordView_Previews: PreviewProvider {
    static var previews: some View {
        AddRecordView()
    }
}

struct FormCell: View {

    @Binding var result: Bool

    var body: some View {
        VStack(spacing: 20) {
            HStack {
                Text("自分")
                Spacer()
                Button(action: {print("tap")}) {
                    FighterPDF(name: "wario")
                        .frame(width: 50, height: 50)
                }
                .background(Color.orange)
                .border(Color.orange, width: 2)
                .cornerRadius(25)
            }
            HStack {
                Text("相手")
                Spacer()
                Button(action: {}) {
                    FighterPDF(name: "byleth")
                        .frame(width: 50, height: 50)
                }
                .background(Color.accentColor)
                .border(Color.accentColor, width: 2)
                .cornerRadius(25)
            }
            HStack {
                Text("ステージ")
                Spacer()
                Button(action: {}) {
                    StagePDF(name: "syuten")
                        .frame(width: 60, height: 40)
                        .cornerRadius(3)
                }
            }
            HStack {
                Text("勝敗")
                Spacer()
                Button(action: {
                    self.result.toggle()
                    print("to")
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


            ScrollView {
                
            }

        }
        .padding(20)
    }
}
