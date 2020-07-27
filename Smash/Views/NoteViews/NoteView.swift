//
//  NoteView.swift
//  Smash
//
//  Created by 村尾慶伸 on 2020/07/20.
//  Copyright © 2020 村尾慶伸. All rights reserved.
//

import SwiftUI

struct NoteView: View {

    let test = testNotes

    @Binding var isTabbarHidden: Bool

    var body: some View {
        NavigationView {
            VStack {
                List {
                    ForEach(test) { note in
                        NavigationLink(destination: NoteDetailView(fighterName: note.fighter, text: note.text, isTabbarHidden: self.$isTabbarHidden)) {
                            HStack {
                                FighterPDF(name: note.fighter)
                                    .frame(width: 25, height: 25)
                                    .padding(.trailing, 5)
                                Text(note.text)
                                    .lineLimit(1)
                            }
                        }
                    }
                    Text("")
                }
            }
            .padding(.horizontal, 20)
            .navigationBarTitle("メモ")
            .onAppear {
                self.isTabbarHidden = false
            }
        }
    }
}

//struct NoteView_Previews: PreviewProvider {
//    static var previews: some View {
//        NoteView()
//    }
//}






