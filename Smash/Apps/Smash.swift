//
//  Smash.swift
//  Smash
//
//  Created by 村尾慶伸 on 2020/10/02.
//  Copyright © 2020 村尾慶伸. All rights reserved.
//

import SwiftUI
import Firebase
import IQKeyboardManagerSwift

@main
struct Smash: App {

    @UIApplicationDelegateAdaptor(Delegate.self) var delegate
    
    var body: some Scene {

        WindowGroup {

            ContentView()
        }
    }
}

class Delegate: NSObject, UIApplicationDelegate {

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {

        FirebaseApp.configure()

        if Auth.auth().currentUser == nil {

            Auth.auth().signInAnonymously()
        }

        
//        IQKeyboardManager.shared.enable = true
        IQKeyboardManager.shared.toolbarTintColor = .orange

        return true
    }
}
