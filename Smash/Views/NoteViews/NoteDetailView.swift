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
import SDWebImageSwiftUI

struct NoteDetailView: View {

    @EnvironmentObject var partialSheetManager : PartialSheetManager
    @Environment (\.colorScheme) var colorScheme: ColorScheme
    @ObservedObject var noteVM = NoteViewModel()
    @ObservedObject var noteCellVM: NoteCellViewModel

    @State private var isBeginEditing: Bool = false
    @State private var isShowPhotoLibrary = false
    @State private var imagesArray: [UIImage] = []

    var onCommit: (Note) -> (Void) = { _ in }

    var body: some View {
        ZStack(alignment: .top) {
            VStack(alignment: .leading) {
                if imagesArray.count != 0 {
                    ShowSelectedPhotos(imagesArray: $imagesArray, noteCellVM: self.noteCellVM)
                }
                MultilineTextField(text: $noteCellVM.note.text, isBeginEditing: $isBeginEditing)
            }
            .padding(10)
        }
        .sheet(isPresented: $isShowPhotoLibrary) {
            ImagePicker(imagesArray: self.$imagesArray, noteVM: self.noteVM, noteCellVM: self.noteCellVM)
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
            UIImage.contentOfFIRStorage(path: url) { image in
                if let image = image {
                    self.imagesArray.append(image)
                }
            }
        }
    }

}

// photo
struct ShowSelectedPhotos: View {
    @Binding var imagesArray: [UIImage]
    @ObservedObject var noteCellVM: NoteCellViewModel

    var body: some View {
        HStack {
            ForEach(imagesArray, id: \.self) { image in
                Image(uiImage: image)
                    .resizable()
                    .scaledToFill()
                    .frame(width: 80, height: 80)
                    .cornerRadius(10)
            }
        }
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

