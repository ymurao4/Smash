//
//  NoteDetailView.swift
//  Smash
//
//  Created by 村尾慶伸 on 2020/07/25.
//  Copyright © 2020 村尾慶伸. All rights reserved.
//

import SwiftUI
import WaterfallGrid
import PartialSheet

struct NoteDetailView: View {

    @EnvironmentObject var partialSheetManager : PartialSheetManager
    @Environment (\.colorScheme) var colorScheme: ColorScheme
    @ObservedObject var noteVM = NoteViewModel()
    @ObservedObject var noteCellVM: NoteCellViewModel

    @State private var isBeginEditing: Bool = false
    @State private var isShowPhotoLibrary: Bool = false
    @State private var isImageSelected: Bool = false

    @State private var selectedIndex: Int = 0
    @State private var imagesArray: [UIImage] = []
    @State private var paths: [String] = []

    var onCommit: (Note) -> (Void) = { _ in }

    var body: some View {
        ZStack(alignment: .top) {
            VStack(alignment: .leading) {
                if imagesArray.count != 0 {
                    ShowSelectedPhotos(noteVM: noteVM, noteCellVM: noteCellVM, imagesArray: $imagesArray, paths: $paths, isImageSelected: $isImageSelected, selectedIndex: $selectedIndex)
                        .sheet(isPresented: $isImageSelected) {
                            ShowImages(imagesArray: self.imagesArray, selectedIndex: self.$selectedIndex)
                    }
                }
                MultilineTextField(text: $noteCellVM.note.text, isBeginEditing: $isBeginEditing)
            }
            .padding(10)

        }
        .navigationBarTitle(Text(""), displayMode: .inline)
        .navigationBarItems(trailing:
            navigationBarTrailingItem()
        )
            .onAppear {
                self.fetchImagesFromStorage()
        }
        .onDisappear {
            self.onCommit(self.noteCellVM.note)
            self.noteVM.deleteEmptyNote(noteCell: self.noteCellVM)
        }
    }

    private func navigationBarTrailingItem() -> some View {
        HStack(spacing: 30) {
            // imagePicker
            Button(action: {
                self.isShowPhotoLibrary.toggle()
                self.isBeginEditing = false
                UIApplication.shared.endEditing()
            }) {
                Image(systemName: "photo")
            }
            .sheet(isPresented: $isShowPhotoLibrary) {
                ImagePicker(imagesArray: self.$imagesArray, noteVM: self.noteVM, noteCellVM: self.noteCellVM)
            }

            // fighter button
            Button(action: {
                // partial sheet
                self.partialSheetManager.showPartialSheet({
                    print("normal sheet dismissed")
                }) {
                    SelectFighterIcon(noteCellVM: self.noteCellVM)
                }
                self.isBeginEditing = false
                UIApplication.shared.endEditing()
            }) {
                if self.noteCellVM.note.fighterName != "" && self.noteCellVM.note.fighterName != nil {
                    FighterPDF(name: self.noteCellVM.note.fighterName!)
                        .frame(width: 25, height: 25)
                } else {
                    Image(systemName: "plus")
                        .resizable()
                        .frame(width: 20, height: 20)
                }
            }
        }
    }

    private func fetchImagesFromStorage() -> Void {
        for url in self.noteCellVM.note.imageURL {
            UIImage.contentOfFIRStorage(path: url) { image, path in
                if let image = image {
                    self.imagesArray.append(image)
                    self.paths.append(path)
                }
            }
        }
    }

}

// photo
struct ShowSelectedPhotos: View {
    @ObservedObject var noteVM: NoteViewModel
    @ObservedObject var noteCellVM: NoteCellViewModel
    @Binding var imagesArray: [UIImage]
    @Binding var paths: [String]
    @Binding var isImageSelected: Bool
    @Binding var selectedIndex: Int
    @State private var isAlert: Bool = false

    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack {
                ForEach(imagesArray.indices, id: \.self) { i in
                    Image(uiImage: self.imagesArray[i])
                        .resizable()
                        .scaledToFill()
                        .frame(width: 80, height: 80)
                        .cornerRadius(10)
                        .onTapGesture {
                            self.isImageSelected.toggle()
                            self.selectedIndex = i
                    }
                    .onLongPressGesture {
                        self.isAlert.toggle()
                        self.selectedIndex = i
                        print(self.imagesArray, self.paths, self.selectedIndex)
                    }
                }
            }
            .alert(isPresented: $isAlert) { () -> Alert in
                showAlert()
            }
        }
    }

    private func showAlert() -> Alert {
        Alert(
            title: Text("本当に削除しますか？"),
            message: Text("この画像を削除します。"),
            primaryButton: .default(Text("削除"),
                                    action: {
                                        if self.imagesArray.count != 0, self.paths.count != 0 {
                                            self.noteVM.deleteImage(path: self.paths[self.selectedIndex], note: &self.noteCellVM.note)
                                            self.imagesArray.remove(at: self.selectedIndex)
                                            self.paths.remove(at: self.selectedIndex)
                                        } else {
                                            
                                        }
            }),
            secondaryButton: .cancel(Text("キャンセル"))
        )
    }
}


// popup
struct SelectFighterIcon: View {

    @ObservedObject var noteCellVM: NoteCellViewModel

    var body: some View {
        VStack {
            WaterfallGrid(S.fightersArray, id: \.self) { fighter in
                Button(action: {
                    self.noteCellVM.note.fighterName = fighter[1]
                }) {
                    FighterPDF(name: fighter[1])
                        .frame(width: 40, height: 40)
                        .background(Color.orange)
                        .cornerRadius(20)
                }
            }
            .gridStyle(
                columns: 6,
                spacing: 5
            )
                .scrollOptions(
                    direction: .vertical,
                    showsIndicators: false
            )

            Button(action: {
                self.noteCellVM.note.fighterName = ""
            }) {
                HStack {
                    Image(systemName: "trash")
                    Text("削除")
                        .font(.headline)
                }
                .padding(EdgeInsets(top: 10, leading: 15, bottom: 10, trailing: 15))
                .foregroundColor(.white)
                .background(LinearGradient(gradient: Gradient(colors: [Color.red, Color.blue]), startPoint: .leading, endPoint: .trailing))
                .cornerRadius(20)
            }
        }
        .frame(maxHeight: UIScreen.main.bounds.size.height / 2)
    }
}

