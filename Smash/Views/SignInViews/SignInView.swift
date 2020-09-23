//
//  SignInView.swift
//  Smash
//
//  Created by 村尾慶伸 on 2020/09/22.
//  Copyright © 2020 村尾慶伸. All rights reserved.
//

import SwiftUI
import Firebase

struct SignInView: View {

    @Environment(\.colorScheme) var colorScheem
    @State var coordinator: SignInWithAppleCoordinator?
    @State private var isLogoutAlert: Bool = false

    let user = Auth.auth().currentUser

    var body: some View {

        VStack {

            if user?.isAnonymous ?? true {

                SignInWithAppleButton()
                    .frame(width: 288, height: 45)
                    .onTapGesture {

                        self.coordinator = SignInWithAppleCoordinator()

                        if let coordinator = self.coordinator {

                            coordinator.startSignInWithAppleFlow() {

                                print("Successfully log out")
                            }
                        }
                    }

            } else {

                Button(action: { self.isLogoutAlert.toggle() }) {

                    HStack {

                        Text("Log Out".localized)
                            .foregroundColor(Color.reverseBackgroundColor(for: colorScheem))
                            .padding()
                    }
                    .frame(width: 288, height: 45)
                    .background(Color.primary)
                    .cornerRadius(40)
                }
            }
        }
        .alert(isPresented: self.$isLogoutAlert) {

            logOutAlert()
        }
    }

    private func logOutAlert() -> Alert {

        Alert(
            title: Text("Log Out"),
            message: Text("Are you sure you want to log out?".localized),
            primaryButton: .default(Text("Log Out".localized),
                                    action: {

                                        logout()
                                    }),
            secondaryButton: .cancel(Text("Cancel".localized))
            )
    }

    private func logout() {

        let auth = Auth.auth()

        do {

            try auth.signOut()
            print("successfully logout")
        } catch let signOutError as NSError {

            print("Error signing out: %@", signOutError)
        }
    }
}
