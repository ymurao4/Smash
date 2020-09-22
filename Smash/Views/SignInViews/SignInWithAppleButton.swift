//
//  SignInWithAppleButton.swift
//  Smash
//
//  Created by 村尾慶伸 on 2020/09/22.
//  Copyright © 2020 村尾慶伸. All rights reserved.
//

import Foundation
import SwiftUI
import AuthenticationServices

struct SignInWithAppleButton: UIViewRepresentable {

    func makeUIView(context: Context) -> ASAuthorizationAppleIDButton {

        return ASAuthorizationAppleIDButton(type: .signIn, style: .black)
    }

    func updateUIView(_ uiView: ASAuthorizationAppleIDButton, context: Context) { }
}
