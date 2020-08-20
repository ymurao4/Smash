//
//  ImagePicker.swift
//  Smash
//
//  Created by 村尾慶伸 on 2020/08/11.
//  Copyright © 2020 村尾慶伸. All rights reserved.
//

import UIKit
import SwiftUI
import Photos

struct ImagePicker: UIViewControllerRepresentable {

    @Environment(\.presentationMode) private var presentationMode
    @Binding var imagesArray: [UIImage]
    @ObservedObject var noteVM: NoteViewModel
    @ObservedObject var noteCellVM: NoteCellViewModel

    func makeUIViewController(context: UIViewControllerRepresentableContext<ImagePicker>) -> UIImagePickerController {
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = context.coordinator
        imagePicker.sourceType = .photoLibrary

        return imagePicker
    }

    func updateUIViewController(_ uiViewController: UIImagePickerController, context: UIViewControllerRepresentableContext<ImagePicker>) {

    }

    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }

    class Coordinator: NSObject, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

        var parent: ImagePicker

        init(_ parent: ImagePicker) {
            self.parent = parent
        }
        
        func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
            if let image = info[.originalImage] as? UIImage {
                self.parent.imagesArray.append(image)
                let url = self.parent.noteVM.uploadImage(image: image)
                self.parent.noteCellVM.note.imageURL.append(url)
            }
            parent.presentationMode.wrappedValue.dismiss()
        }

    }

}

