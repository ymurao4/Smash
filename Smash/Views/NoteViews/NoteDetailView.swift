//
//  NoteDetailView.swift
//  Smash
//
//  Created by 村尾慶伸 on 2020/07/25.
//  Copyright © 2020 村尾慶伸. All rights reserved.
//

import SwiftUI
import PartialSheet

struct NoteDetailView: View {

    @EnvironmentObject var partialSheetManager : PartialSheetManager
    @Environment (\.colorScheme) var colorScheme: ColorScheme
    @ObservedObject var noteVM = NoteViewModel()
    @ObservedObject var noteCellVM: NoteCellViewModel

    @State private var isBeginEditing: Bool = false
    @State private var isImageSelected: Bool = false
    @State private var isShowPhotoLibrary: Bool = false
    @State private var paths: [String] = []

    @State private var images: [UIImage] = []

    var onCommit: (Note) -> (Void) = { _ in }

    var body: some View {

        ZStack(alignment: .top) {

            VStack(alignment: .leading) {


                if !images.isEmpty {

                    ShowSelectedPhotos(noteVM: noteVM, noteCellVM: noteCellVM, images: $images, paths: $paths, isImageSelected: $isImageSelected)
                }

                MultilineTextField(text: $noteCellVM.note.text, isBeginEditing: $isBeginEditing)
                    .padding(.horizontal, 10)
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
                
                ImagePicker(images: self.$images, noteVM: self.noteVM, noteCellVM: self.noteCellVM)
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

                    self.images.append(image)
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
    @Binding var images: [UIImage]
    @Binding var paths: [String]
    @Binding var isImageSelected: Bool
    @State var selectedIndex: Int = 0
    @State private var isAlert: Bool = false

    @State private var x: CGFloat = 0
    @State private var count: CGFloat = 0
    @State private var screen: CGFloat = UIScreen.main.bounds.width - 30

    var body: some View {

        HStack(spacing: 15) {

            ForEach(images, id: \.self) { image in

                CardView(image: image)
                    .offset(x: self.x)
                    .highPriorityGesture(DragGesture()
                        .onChanged({ (value) in

                            if value.translation.width > 0 {

                                self.x = value.location.x
                            } else {

                                self.x = value.location.x - screen
                            }
                        })
                        .onEnded({ (value) in

                            if value.translation.width > 0 {

                                if value.translation.width > ((screen - 80) / 2) && Int(self.count) != self.getMid() {

                                    self.count += 1
                                    self.x = (screen + 15) * self.count // spacingが15だから
                                } else {

                                    self.x = (screen + 15) * self.count
                                }
                            } else {

                                if -value.translation.width > ((screen - 80) / 2) && -Int(self.count) != self.getMid() {

                                    self.count -= 1
                                    self.x = (screen + 15) * self.count
                                } else {

                                    self.x = (screen + 15) * self.count
                                }
                            }
                        })
                    )
            }
        }
        .frame(width: screen + 30, height: 460)
        .animation(.spring())
        .alert(isPresented: $isAlert) { () -> Alert in

            showAlert()
        }
    }

    private func showAlert() -> Alert {

        Alert(

            title: Text("Are you sure?".localized),
            message: Text("Do you want to delete this image?".localized),
            primaryButton: .default(Text("Delete".localized),
                                    action: {

                                        if self.images.count != 0, self.paths.count != 0, selectedIndex < self.paths.count {

                                            self.noteVM.deleteImage(path: self.paths[self.selectedIndex], note: &self.noteCellVM.note)
                                            self.images.remove(at: self.selectedIndex)
                                            self.paths.remove(at: self.selectedIndex)
                                        }
                                    }),
            secondaryButton: .cancel(Text("Cancel".localized))
        )
    }

    private func getMid() -> Int {

        return images.count / 2
    }
}

// popup
struct SelectFighterIcon: View {

    @ObservedObject var noteCellVM: NoteCellViewModel
    let column = GridItem(.flexible(minimum: 40, maximum: 60))

    var body: some View {

        ScrollView(showsIndicators: false) {

            LazyVGrid(columns: Array(repeating: column, count: 7), spacing: 20) {

                ForEach(S.fightersArray, id: \.self) { item in

                    Button(action: { self.noteCellVM.note.fighterName = item[1] }) {

                        FighterPDF(name: item[1])
                            .frame(width: 40, height: 40)
                            .background(Color.orange)
                            .cornerRadius(20)
                    }
                }
            }

            Button(action: { self.noteCellVM.note.fighterName = "" }) {

                HStack {

                    Image(systemName: "trash")

                    Text("Delete".localized)
                        .font(.headline)
                }
                .padding(EdgeInsets(top: 10, leading: 30, bottom: 10, trailing: 30))
                .foregroundColor(.white)
                .background(LinearGradient(gradient: Gradient(colors: [Color.red, Color.blue]), startPoint: .leading, endPoint: .trailing))
                .cornerRadius(20)
            }
        }
    }
}

struct CardView: View {

    var image: UIImage

    var body: some View {

        VStack(alignment: .leading, spacing: 0) {

            Image(uiImage: image)
                .resizable()
                .frame(width: UIScreen.main.bounds.width - 30, height: 460)
        }
        .cornerRadius(25)
    }
}
