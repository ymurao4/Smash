//
//  MultilineTextField.swift
//  Smash
//
//  Created by 村尾慶伸 on 2020/07/25.
//  Copyright © 2020 村尾慶伸. All rights reserved.
//

import Foundation
import SwiftUI

struct MultilineTextField: UIViewRepresentable {

    @Binding var text: String
    @Binding var isBeginEditing: Bool

    func makeUIView(context: Context) -> UITextView {
        let view = UITextView()
        view.delegate = context.coordinator
        view.isScrollEnabled = true
        view.isEditable = true
        view.isUserInteractionEnabled = true
        view.font = UIFont.systemFont(ofSize: 18)

        // toolbar
        let toolBar = UIToolbar()
        let doneButton = UIBarButtonItem(title: "Done", style: .plain, target: self, action: nil)
        let flexSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let cancelButton = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: nil)
        let items = [cancelButton, flexSpace, doneButton]
        toolBar.items = items
        toolBar.barStyle = UIBarStyle.default
        toolBar.sizeToFit()
        view.inputAccessoryView = toolBar

        return view
    }

    func updateUIView(_ uiView: UITextView, context: Context) {
        if uiView.text != text {
            uiView.text = text
        }
    }

    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }


    class Coordinator: NSObject, UITextViewDelegate {
        var parent: MultilineTextField

        init(_ textView: MultilineTextField) {
            self.parent = textView
        }

        func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
            return true
        }

        func textViewDidChange(_ textView: UITextView) {
            self.parent.text = textView.text
        }

        func textViewDidEndEditing(_ textView: UITextView) {
            self.parent.isBeginEditing = false
        }

        func textViewDidBeginEditing(_ textView: UITextView) {
            self.parent.isBeginEditing = true
        }

    }

}
