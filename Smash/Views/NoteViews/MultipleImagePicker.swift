//
//  ImagePicker.swift
//  Smash
//
//  Created by 村尾慶伸 on 2020/08/11.
//  Copyright © 2020 村尾慶伸. All rights reserved.
//

import UIKit
import SwiftUI
import AssetsPickerViewController
import Photos
import Fusuma

/*
struct MultipleImagePicker: UIViewControllerRepresentable {

    @Environment(\.presentationMode) private var presentationMode
    @Binding var selectedImages: [UIImage]
    @ObservedObject var noteVM: NoteViewModel

    func makeUIViewController(context: UIViewControllerRepresentableContext<MultipleImagePicker>) -> AssetsPickerViewController {
        let picker = AssetsPickerViewController()
        picker.delegate = context.coordinator

        return picker
    }

    func updateUIViewController(_ uiViewController: AssetsPickerViewController, context: UIViewControllerRepresentableContext<MultipleImagePicker>) {

    }

    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }

    class Coordinator: NSObject, AssetsPickerViewControllerDelegate, UINavigationControllerDelegate {

        var parent: MultipleImagePicker

        init(_ parent: MultipleImagePicker) {
            self.parent = parent
        }

        func assetsPicker(controller: AssetsPickerViewController, selected assets: [PHAsset]) {
            for asset in assets {
                let image = getAssetThumbnail(asset: asset)
                self.parent.selectedImages.append(image)
            }
        }

        func assetsPickerCannotAccessPhotoLibrary(controller: AssetsPickerViewController) {}
        func assetsPickerDidCancel(controller: AssetsPickerViewController) {}
        func assetsPicker(controller: AssetsPickerViewController, shouldSelect asset: PHAsset, at indexPath: IndexPath) -> Bool {
            return true
        }
        func assetsPicker(controller: AssetsPickerViewController, didSelect asset: PHAsset, at indexPath: IndexPath) {}
        func assetsPicker(controller: AssetsPickerViewController, shouldDeselect asset: PHAsset, at indexPath: IndexPath) -> Bool {
            return true
        }
        func assetsPicker(controller: AssetsPickerViewController, didDeselect asset: PHAsset, at indexPath: IndexPath) {}

        // PHAsset -> UIImage
        private func getAssetThumbnail(asset: PHAsset) -> UIImage {
            var retImage = UIImage()
            let manager = PHImageManager.default()
            manager.requestImage(for: asset, targetSize: CGSize(width: 100, height: 100), contentMode: .aspectFit, options: nil) { (result, info) -> Void in
                retImage = result!
            }
            return retImage
        }

    }

}
 */

struct MultiImagePicker: UIViewControllerRepresentable {

    @Environment(\.presentationMode) private var presentationMode
    @Binding var selectedImages: [UIImage]
    @ObservedObject var noteVM: NoteViewModel

    func makeUIViewController(context: UIViewControllerRepresentableContext<MultiImagePicker>) -> FusumaViewController {
        let fusuma = FusumaViewController()
        fusuma.delegate = context.coordinator
        fusuma.availableModes = [.library, .camera]
        fusuma.cropHeightRatio = 0.6
        fusuma.allowMultipleSelection = true
        return fusuma
    }

    func updateUIViewController(_ uiViewController: FusumaViewController, context: UIViewControllerRepresentableContext<MultiImagePicker>) {

    }

    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }

    class Coordinator: NSObject, UINavigationControllerDelegate, FusumaDelegate {

        var parent: MultiImagePicker

        init(_ parent: MultiImagePicker) {
            self.parent = parent
        }

        // Return the image which is selected from camera roll or is taken via the camera.
        func fusumaImageSelected(_ image: UIImage, source: FusumaMode) {

          print("Image selected")
        }

        // Return the image but called after is dismissed.
        func fusumaDismissedWithImage(image: UIImage, source: FusumaMode) {

          print("Called just after FusumaViewController is dismissed.")
        }

        func fusumaVideoCompleted(withFileURL fileURL: URL) {

          print("Called just after a video has been selected.")
        }

        // When camera roll is not authorized, this method is called.
        func fusumaCameraRollUnauthorized() {

          print("Camera roll unauthorized")
        }

        // Return selected images when you allow to select multiple photos.
        func fusumaMultipleImageSelected(_ images: [UIImage], source: FusumaMode) {

        }

        // Return an image and the detailed information.
        func fusumaImageSelected(_ image: UIImage, source: FusumaMode, metaData: ImageMetadata) {

        }


    }

}
