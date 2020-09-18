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

    var body: some View {

        ListView(images: images)
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

struct ListView: View {

    var images: [UIImage]

    var body: some View {

        GeometryReader { proxy in

            UIScrollViewWrapper {

                HStack(spacing: 0) {

                    ForEach(images, id: \.self) { image in

                        CardView(image: image, width: proxy.size.width)
                    }
                }
            }
        }
    }
}

struct CardView: View {

    var image: UIImage
    var width: CGFloat

    var body: some View {

        VStack {

            Image(uiImage: image)
                .resizable()
                .frame(width: self.width, height: 400)
        }
        .frame(width: self.width, height: 400)
    }
}


class UIScrollViewViewController: UIViewController {

    lazy var scrollView: UIScrollView = {
        let v = UIScrollView()
        v.isPagingEnabled = true
        v.showsVerticalScrollIndicator = false
        v.showsHorizontalScrollIndicator = false
        return v
    }()

    var hostingController: UIHostingController<AnyView> = UIHostingController(rootView: AnyView(EmptyView()))

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.addSubview(self.scrollView)
        self.pinEdges(of: self.scrollView, to: self.view)

        self.hostingController.willMove(toParent: self)
        self.scrollView.addSubview(self.hostingController.view)
        self.pinEdges(of: self.hostingController.view, to: self.scrollView)
        self.hostingController.didMove(toParent: self)

    }

    func pinEdges(of viewA: UIView, to viewB: UIView) {
        viewA.translatesAutoresizingMaskIntoConstraints = false
        viewB.addConstraints([
            viewA.leadingAnchor.constraint(equalTo: viewB.leadingAnchor),
            viewA.trailingAnchor.constraint(equalTo: viewB.trailingAnchor),
            viewA.topAnchor.constraint(equalTo: viewB.topAnchor),
            viewA.bottomAnchor.constraint(equalTo: viewB.bottomAnchor),
        ])
    }

}

struct UIScrollViewWrapper<Content: View>: UIViewControllerRepresentable {

    var content: () -> Content

    init(@ViewBuilder content: @escaping () -> Content) {
        self.content = content
    }

    func makeUIViewController(context: Context) -> UIScrollViewViewController {
        let vc = UIScrollViewViewController()
        vc.hostingController.rootView = AnyView(self.content())
        return vc
    }

    func updateUIViewController(_ viewController: UIScrollViewViewController, context: Context) {
        viewController.hostingController.rootView = AnyView(self.content())
    }
}
