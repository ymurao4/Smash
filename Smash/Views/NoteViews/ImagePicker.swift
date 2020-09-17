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
import PhotosUI

struct ImagePicker: UIViewControllerRepresentable {

    @Environment(\.presentationMode) private var presentationMode
    @Binding var images: [UIImage]
    @ObservedObject var noteVM: NoteViewModel
    @ObservedObject var noteCellVM: NoteCellViewModel

    func makeUIViewController(context: Context) -> PHPickerViewController {

        var config = PHPickerConfiguration()
        config.filter = .images
        config.selectionLimit = 0
        let picker = PHPickerViewController(configuration: config)
        picker.delegate = context.coordinator
        return picker
    }

    func updateUIViewController(_ uiViewController: PHPickerViewController, context: Context) {

    }

    func makeCoordinator() -> Coordinator {

        return ImagePicker.Coordinator(imagePicker: self)
    }

    class Coordinator: NSObject, PHPickerViewControllerDelegate {

        var parent: ImagePicker

        init(imagePicker: ImagePicker) {

            self.parent = imagePicker
        }

        func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {

            for img in results {

                if img.itemProvider.canLoadObject(ofClass: UIImage.self) {

                    img.itemProvider.loadObject(ofClass: UIImage.self) { (image, error) in

                        guard let image = image else { return }


                        DispatchQueue.main.async {

                            self.parent.images.append(image as! UIImage)
                            let url = self.parent.noteVM.uploadImage(image: image as! UIImage)
                            self.parent.noteCellVM.note.imageURL.append(url)
                        }
                    }
                } else {

                    print("cannnot be loaded...")
                }
            }
            self.parent.presentationMode.wrappedValue.dismiss()
        }
    }
}
