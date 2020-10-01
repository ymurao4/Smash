//
//  AnalysisView.swift
//  Smash
//
//  Created by 村尾慶伸 on 2020/07/21.
//  Copyright © 2020 村尾慶伸. All rights reserved.
//

import SwiftUI

struct AnalysisView: View {

    @ObservedObject var analysisVM = AnalysisViewModel(sortName: "opponentFighter")
    @State private var selectedIndex: Int = 0
    @State var isFighterIcon: Bool = false
    private let pickerName: [String] = ["Main", "Me", "Opponent", "Stage"]
    private let sortedName: [String] = ["", "Game", "Win", "Lose", "Rate"]

    var body: some View {

        NavigationView {

            ZStack(alignment: .bottom) {

                VStack {

                    Picker("", selection: $selectedIndex) {

                        ForEach(0..<self.pickerName.count) { index in

                            Text(self.pickerName[index].localized)
                                .tag(index)
                        }
                    }
                    .pickerStyle(SegmentedPickerStyle())

                    HStack {

                        ForEach(sortedName, id: \.self) { name in

                            Text(name.localized)
                                .frame(maxWidth: .infinity)
                                .minimumScaleFactor(0.5)
                                .lineLimit(1)
                        }
                        .font(.subheadline)
                    }
                    .padding(.horizontal)
                    .padding(.top, 5)

                    if selectedIndex == 0 {

                        AnalysisMainFighterView()
                    } else if selectedIndex == 1 {

                        AnalysisMyFighterView()
                    } else if selectedIndex == 2 {

                        AnalysisOpponentFighterView()
                    } else if selectedIndex == 3 {

                        AnalysisStageView()
                    }
                }
                .padding(.top, 50)

                VStack {

                    Spacer()

                    SelectMainFighterIcon(analysisVM: analysisVM)
                        .offset(y: isFighterIcon ? 0 : UIScreen.main.bounds.height)
                }
                .background((isFighterIcon ? Color.black.opacity(0.3) : Color.clear)
                .edgesIgnoringSafeArea(.all)
                .onTapGesture {

                    self.isFighterIcon.toggle()
                    }
                )
                .ignoresSafeArea(.all, edges: .bottom)
            }
            .navigationBarTitle(Text("Analysis".localized))
            .navigationBarItems(trailing:
                Button(action: {

                    self.isFighterIcon.toggle()
                }) {
                    
                    FighterPDF(name: self.analysisVM.mainFighter)
                        .frame(width: 30, height: 30)
                }
            )
        }
    }
}

struct AnalysisView_Previews: PreviewProvider {
    static var previews: some View {
        AnalysisView()
    }
}

struct SelectMainFighterIcon: View {

    @ObservedObject var analysisVM: AnalysisViewModel
//    @Binding var isFighterIcon: Bool
    let column = GridItem(.flexible(minimum: 40, maximum: 60))

    var body: some View {

        ScrollView(showsIndicators: false) {

            VStack {

                LazyVGrid(columns: Array(repeating: column, count: 7), spacing: 20) {

                    ForEach(S.fightersArray, id: \.self) { item in

                        Button(action: {

                            self.analysisVM.updateMainFighter(fighterName: item[1])
                        }) {

                            FighterPDF(name: item[1])
                                .frame(width: 40, height: 40)
                                .background(Color.orange)
                                .cornerRadius(20)
                        }
                    }
                }
            }
            .padding(.top)
            .padding(.bottom, 50)
            .padding(.horizontal, 5)
        }
        .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height - 200)
        .background(BlurView(style: .systemMaterial))
        .padding(.bottom, (UIApplication.shared.windows.last?.safeAreaInsets.bottom)! + 10)
        .cornerRadius(25)
    }
}
