//
//  AddRecordView.swift
//  Smash
//
//  Created by 村尾慶伸 on 2020/07/21.
//  Copyright © 2020 村尾慶伸. All rights reserved.
//

import SwiftUI

struct AddRecordView: View {
    
    @StateObject var recordListVM: RecordListViewMdoel
    
    @Environment(\.presentationMode) var presentatinoMode
    @State private var selectedIndex: Int = 0
    @State private var myFighterName: String = "mario"
    @State private var opponentFighterName: String = "mario"
    @State private var stageName: String = "final"
    @State private var result: Bool = true
    
    private let pickerNames = ["Me", "Opponent", "Stage"]
    
    private let userDefaults = UserDefaults.standard
    
    var device = UIDevice.current.userInterfaceIdiom
    
    var stringResult = { (result: Bool) -> String in
        
        if result {
            return "win"
        } else {
            return "lose"
        }
    }
    
    var body: some View {
        
        // MARK: iPHONE
        if device == .phone {
            
            NavigationView {
                
                VStack {
                    
                    FormCell(myFighterName: $myFighterName, opponentFighterName: $opponentFighterName, stageName: $stageName, result: $result, selectedIndex: $selectedIndex)
                    
                    Spacer()
                        .frame(height: 20)
                    
                    Picker("", selection: $selectedIndex) {
                        
                        ForEach(0..<self.pickerNames.count) { index in
                            
                            Text(self.pickerNames[index].localized)
                                .tag(index)
                        }
                    }
                    .pickerStyle(SegmentedPickerStyle())
                    .padding(.bottom, 10)
                    
                    if selectedIndex == 0 {
                        
                        MyFighterView(fighterName: $myFighterName)
                    } else if selectedIndex == 1 {
                        
                        OpponentFighterView(opponentFighterName: $opponentFighterName)
                    } else if selectedIndex == 2 {
                        
                        StageView(stageName: $stageName)
                    }
                }
                .onAppear {
                    
                    self.loadPreviousFighterName()
                }
                .padding(20)
                .navigationBarTitle(Text("Result".localized), displayMode: .inline)
                .navigationBarItems(
                    
                    leading:
                        
                        Button(action: {
                            
                            self.presentatinoMode.wrappedValue.dismiss()
                        }) {
                            
                            Text("Cancel".localized)
                                .foregroundColor(.orange)
                        },
                    
                    trailing:
                        
                        Button(action: {
                            
                            self.recordListVM.addRecord(record: Record(result: self.stringResult(self.result), myFighter: self.myFighterName, opponentFighter: self.opponentFighterName, stage: self.stageName))
                            
                            savePrevFighterName()
                            
                            self.presentatinoMode.wrappedValue.dismiss()
                        }) {
                            
                            Image(systemName: "checkmark")
                                .resizable()
                                .frame(width: 20, height: 20)
                                .foregroundColor(Color.orange)
                        }
                )
            }
        }
        
        //MARK: iPAD
        else {
            
            VStack {
                
                HStack {
                    
                    FormCell(myFighterName: $myFighterName, opponentFighterName: $opponentFighterName, stageName: $stageName, result: $result, selectedIndex: $selectedIndex)
                    
                    Button(action: {

                        self.recordListVM.addRecord(record: Record(result: self.stringResult(self.result), myFighter: self.myFighterName, opponentFighter: self.opponentFighterName, stage: self.stageName))

                        savePrevFighterName()
                    }) {

                        Image(systemName: "checkmark")
                            .resizable()
                            .frame(width: 20, height: 20)
                            .foregroundColor(Color.orange)
                    }
                }
                
                Spacer()
                    .frame(height: 20)
                
                Picker("", selection: $selectedIndex) {
                    
                    ForEach(0..<self.pickerNames.count) { index in
                        
                        Text(self.pickerNames[index].localized)
                            .tag(index)
                    }
                }
                .pickerStyle(SegmentedPickerStyle())
                .padding(.bottom, 10)
                
                if selectedIndex == 0 {
                    
                    MyFighterView(fighterName: $myFighterName)
                } else if selectedIndex == 1 {
                    
                    OpponentFighterView(opponentFighterName: $opponentFighterName)
                } else if selectedIndex == 2 {
                    
                    StageView(stageName: $stageName)
                }
            }
            .onAppear {
                
                self.loadPreviousFighterName()
            }
        }
    }
    
    func loadPreviousFighterName() {
        userDefaults.register(defaults: ["PrevFighter": "mario"])
        
        myFighterName = userDefaults.object(forKey: "PrevFighter") as! String
    }
    
    func savePrevFighterName() {
        
        userDefaults.register(defaults: ["PrevFighter": "mario"])
        
        userDefaults.set(myFighterName, forKey: "PrevFighter")
    }
}


struct FormCell: View {
    
    @Binding var myFighterName: String
    @Binding var opponentFighterName: String
    @Binding var stageName: String
    @Binding var result: Bool
    @Binding var selectedIndex: Int
    
    var body: some View {
        
        HStack(alignment: .top, spacing: 20) {
            
            VStack {
                
                Text("Result".localized)
                    .padding(.bottom, 15)
                
                HStack {
                    
                    Button(action: { self.result.toggle() }) {
                        
                        Text("Win".localized)
                            .font(.subheadline)
                    }
                    .frame(width: 40, height: 30)
                    .background(result ? Color.orange : nil)
                    .foregroundColor(result ? .white : Color.primary)
                    .cornerRadius(5)
                    .padding(.trailing, 7)
                    
                    Button(action: { self.result.toggle() }) {
                        
                        Text("Lose".localized)
                            .font(.subheadline)
                    }
                    .frame(width: 40, height: 30)
                    .background(!result ? Color.orange : nil)
                    .foregroundColor(!result ? .white : Color.primary)
                    .cornerRadius(5)
                }
            }
            VStack {
                
                Text("Me".localized)
                
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
                
                Text("Opponent".localized)
                    .scaledToFill()
                    .minimumScaleFactor(0.5)
                    .lineLimit(1)
                
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
                
                Text("Stage".localized)
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



struct MyFighterView: View {
    
    @Binding var fighterName: String
    let column = GridItem(.flexible(minimum: 40, maximum: 60))
    let i = "fighterName"
    
    var body: some View {
        
        IconSetting(name: $fighterName, identifier: i, array: S.fightersArray)
    }
}

struct OpponentFighterView: View {
    
    @Binding var opponentFighterName: String
    let i = "opponentFighterName"
    
    var body: some View {
        
        IconSetting(name: $opponentFighterName, identifier: i, array: S.fightersArray)
    }
}

struct StageView: View {
    
    @Binding var stageName: String
    let column = GridItem(.flexible(minimum: 80, maximum: 150))
    var imageWidth: CGFloat {
        
        calImageWidth()
    }
    
    var body: some View {
        
        ScrollView(showsIndicators: false) {
            
            LazyVGrid(columns: Array(repeating: column, count: 3), spacing: 40) {
                
                ForEach(S.stageArray, id: \.self) { item in
                    
                    VStack(spacing: 5) {
                        
                        Button(action: { self.stageName = item[1] }) {
                            
                            StagePDF(name: item[1])
                                .frame(width: self.imageWidth, height: self.imageWidth / 1.78)
                                .cornerRadius(10)
                                .scaledToFill()
                        }
                        
                        Text(item[0])
                            .font(.footnote)
                    }
                }
            }
        }
    }
    
    private func calImageWidth() -> CGFloat {
        let currentWidth = UIScreen.main.bounds.width
        return (currentWidth) / 4
    }
}

struct IconSetting: View {
    
    @Binding var name: String
    var identifier: String
    var array: [[String]]
    let column = GridItem(.flexible(minimum: 40, maximum: 60))
    
    var body: some View {
        
        ScrollView(showsIndicators: false) {
            
            LazyVGrid(columns: Array(repeating: column, count: 7), spacing: 20) {
                
                ForEach(array, id: \.self) { item in
                    
                    Button(action: { name = item[1] }) {
                        
                        FighterPDF(name: item[1])
                            .frame(width: 40, height: 40)
                            .background(self.identifier == "fighterName" ? Color.orange : Color.blue)
                            .cornerRadius(20)
                    }
                }
            }
        }
    }
}
