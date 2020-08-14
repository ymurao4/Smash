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
    // for upload
    @State private var image = UIImage()
    @State private var callbackImage: UIImage?

    var onCommit: (Note) -> (Void) = { _ in }

    var body: some View {
        ZStack(alignment: .top) {
            ScrollView(.vertical, showsIndicators: false) {
                VStack(alignment: .center) {
                    if image.size.width != 0 || callbackImage?.size.width != 0 {
                        ShowSelectedPhotos(image: $image, callbackImage: $callbackImage, noteCellVM: self.noteCellVM)
                    }
                    MultilineTextField(text: $noteCellVM.note.text, isBeginEditing: $isBeginEditing)
                }
            }
            .padding(10)
        }
        .sheet(isPresented: $isShowPhotoLibrary) {
            ImagePicker(selectedImage: self.$image, noteVM: self.noteVM, noteCellVM: self.noteCellVM)
        }
        .navigationBarTitle(Text(""), displayMode: .inline)
        .navigationBarItems(trailing:
            navigationBarTrailingItem()
        )
            .onAppear {
                UIImage.contentOfFIRStorage(path: self.noteCellVM.note.imageURL) { image in
                    self.callbackImage = image
                }
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
}

// photo
struct ShowSelectedPhotos: View {
    @Binding var image: UIImage
    @Binding var callbackImage: UIImage?
    @ObservedObject var noteCellVM: NoteCellViewModel

    var body: some View {
        VStack {
            if self.noteCellVM.note.id == nil {
                Image(uiImage: image)
                    .resizable()
                    .renderingMode(.original)
                    .scaledToFill()
                    .frame(maxWidth: UIScreen.main.bounds.width * 0.9, maxHeight: UIScreen.main.bounds.height * 0.8)
                    .cornerRadius(10)
            } else {
                if callbackImage != nil {
                    Image(uiImage: callbackImage!)
                        .resizable()
                        .renderingMode(.original)
                        .scaledToFill()
                        .frame(maxWidth: UIScreen.main.bounds.width * 0.9, maxHeight: UIScreen.main.bounds.height * 0.8)
                        .cornerRadius(10)
                } else {
                    Loader()
                }
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

