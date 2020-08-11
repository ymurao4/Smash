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
    @ObservedObject var noteCellVM: NoteCellViewModel
    @ObservedObject var noteVM = NoteViewModel()

    @State private var isBeginEditing: Bool = false
    @State private var isShowPhotoLibrary = false
    // for upload
    @State var images = [UIImage]()

    var onCommit: (Note) -> (Void) = { _ in }

    var body: some View {
        ZStack(alignment: .top) {
            VStack(alignment: .leading) {
                if images.count != 0 {
                    ShowSelectedPhotos(images: images, noteVM: self.noteVM)
                }
                MultilineTextField(text: $noteCellVM.note.text, isBeginEditing: $isBeginEditing)
            }
            .padding(10)
        }
        .sheet(isPresented: $isShowPhotoLibrary) {
            ImagePicker(selectedImages: self.$images, sourceType: .photoLibrary)
                .edgesIgnoringSafeArea(.all)
        }
        .navigationBarTitle(Text(""), displayMode: .inline)
        .navigationBarItems(trailing:
            navigationBarTrailingItem()
        )
            .onAppear {
                self.noteVM.loadImages()
        }
            .onDisappear {
                self.onCommit(self.noteCellVM.note)
                self.noteVM.deleteEmptyNote(noteCell: self.noteCellVM)
                if self.images.count != 0 {
                    self.noteVM.uploadImages(images: self.images)
                }
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
    var images: [UIImage]
    var noteVM: NoteViewModel

    var body: some View {
        ScrollView(.horizontal) {
            HStack {
                ForEach(images, id: \.self) { image in
                    Image(uiImage: image)
                        .resizable()
                        .frame(width: 80, height: 80)
                        .scaledToFill()
                        .cornerRadius(10)
                }
//                if self.noteVM.imageURL != "" {
//                    AnimatedImage(url: URL(string: self.noteVM.imageURL))
//                        .frame(width: 80, height: 80)
//                        .cornerRadius(10)
//                } else {
//                    Loader()
//                }
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


struct Loader: UIViewRepresentable {
    func makeUIView(context: UIViewRepresentableContext<Loader>) -> UIActivityIndicatorView {
        let indicator = UIActivityIndicatorView(style: .large)
        indicator.startAnimating()
        return indicator
    }
    func updateUIView(_ uiView: UIActivityIndicatorView, context: UIViewRepresentableContext<Loader>) {

    }
}
