//
//  NoteDetailView.swift
//  Smash
//
//  Created by 村尾慶伸 on 2020/07/25.
//  Copyright © 2020 村尾慶伸. All rights reserved.
//

import SwiftUI

struct NoteDetailView: View {

    @State var fighterName: String
    @State var text: String = ""
    @Binding var isTabbarHidden: Bool

    var body: some View {
        VStack {
            MultilineTextField(text: $text)
        }
        .padding(.horizontal, 10)
        .navigationBarTitle(Text(fighterName), displayMode: .inline)
        .onAppear {
            self.isTabbarHidden = true
        }
    }
}

