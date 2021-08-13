//
//  RecordVIew.swift
//  Smash
//
//  Created by 村尾慶伸 on 2020/07/20.
//  Copyright © 2020 村尾慶伸. All rights reserved.

import SwiftUI

struct RecordView: View {

    @StateObject var recordListVM = RecordListViewMdoel()
    @State private var isSheet: Bool = false
    @State private var isAlert: Bool = false
    @State private var isActionSheet: Bool = false
    @State private var isAccount: Bool = false
    @State private var recordID: String?
    
    var device = UIDevice.current.userInterfaceIdiom

    private func showDeleteAlert(index: IndexSet) {
        isAlert.toggle()
        self.recordID = self.recordListVM.recordCellViewModels[index.first!].id
    }

    var body: some View {

        NavigationView {

            //MARK: iPHONE
            if device == .phone {
                
                VStack(alignment: .leading) {

                    Button(action: {

                        self.isSheet.toggle()
                    }) {

                        HStack {

                            Image(systemName: "plus.circle.fill")
                                .resizable()
                                .frame(width: 20, height: 20)
                            Text("Add a record".localized)
                        }
                    }
                    .padding(EdgeInsets(top: 10, leading: 20, bottom: 0, trailing: 20))
                    .fullScreenCover(isPresented: $isSheet) {
                        
                        AddRecordView(recordListVM: recordListVM)
                    }

                    List{

                        ForEach(recordListVM.recordCellViewModels) { recordCellVM in

                            ResultCell(recordCellVM: recordCellVM)
                        }
                        .onDelete(perform: showDeleteAlert)
                        .alert(isPresented: $isAlert) {

                            showAlert()
                        }
                    }
                    .sheet(isPresented: $isAccount) {

                        SignInView()
                    }
                }
                .navigationBarTitle("Battle Record".localized)
                .navigationBarItems(
                    leading:
    
                        Button(action: { self.isActionSheet.toggle() }) {
    
                            Image(systemName: "gear")
                                .resizable()
                                .frame(width: 20, height: 20)
                        },
                    trailing: EditButton()
                )
                .actionSheet(isPresented: $isActionSheet) {

                    ActionSheet(
                        title: Text("Settings".localized),
                        message: Text(""),
                        buttons: [
                            .default(Text("Account".localized),
                                     action: {
                                        self.isAccount.toggle()
                                     }),
                            .default(Text("Language".localized)),
                            .default(Text("App Version".localized)),
                            .cancel()
                        ])
                    }
            }
            
            //MARK: iPAD
            else {
                
                HStack {
                    
                    // Left Side
                    VStack(alignment: .leading) {

                        List{

                            ForEach(recordListVM.recordCellViewModels) { recordCellVM in

                                ResultCell(recordCellVM: recordCellVM)
                            }
                            .onDelete(perform: showDeleteAlert)
                            .alert(isPresented: $isAlert) {

                                showAlert()
                            }
                        }
                        .sheet(isPresented: $isAccount) {

                            SignInView()
                        }
                    }
                    
                    EdgeBorder(width: 2, edge: .trailing)
                        .frame(width: 2)
                        .foregroundColor(.gray.opacity(0.5))
                    
                    AddRecordView(recordListVM: recordListVM)
                }
                .navigationBarTitle("Battle Record".localized)
                .navigationBarItems(
                    leading:
    
                        Button(action: { self.isActionSheet.toggle() }) {
    
                            Image(systemName: "gear")
                                .resizable()
                                .frame(width: 20, height: 20)
                        },
                    trailing: EditButton()
                )
                .actionSheet(isPresented: $isActionSheet) {

                    ActionSheet(
                        title: Text("Settings".localized),
                        message: Text(""),
                        buttons: [
                            .default(Text("Account".localized),
                                     action: {
                                        self.isAccount.toggle()
                                     }),
                            .default(Text("Language".localized)),
                            .default(Text("App Version".localized)),
                            .cancel()
                        ])
                    }
            }
        }
        .navigationViewStyle(StackNavigationViewStyle())
    }

    private func showAlert() -> Alert {

        Alert(
            title: Text("Are you sure?".localized),
            message: Text("Do you want to delete this record?".localized),
            primaryButton: .default(Text("Delete".localized),
                                    action: {

                                        self.recordListVM.deleteRecord(recordID: self.recordID)
                                    }),
            secondaryButton: .cancel(Text("Cancel".localized))
        )
    }
}

struct RecordVIew_Previews: PreviewProvider {

    static var previews: some View {

        RecordView()
            .previewDevice(PreviewDevice(rawValue: "iPhone 12 Pro"))
            .previewDisplayName("iPhone 12 Pro")
        
        RecordView()
            .previewDevice("iPad Pro (12.9-inch) (5th generation)")
            .previewDisplayName("iPad Pro 12.9")
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

        HStack(alignment: .center, spacing: 10) {

            VStack(alignment: .center, spacing: 5) {

                Text(recordCellVM.record.result)
                    .minimumScaleFactor(0.5)

                Text(recordCellVM.date)
                    .font(.caption)
            }
            .frame(maxWidth: .infinity)

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
            .frame(maxWidth: .infinity)
        }
        .border(width: 5, edge: .leading, color: self.borderColor(recordCellVM.record))
    }
}

extension View {
    
    func border(width: CGFloat, edge: Edge, color: Color) -> some View {
        
        overlay(EdgeBorder(width: width, edge: edge).foregroundColor(color))
    }
}

