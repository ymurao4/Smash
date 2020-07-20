//
//  ContentView.swift
//  Smash
//
//  Created by 村尾慶伸 on 2020/07/20.
//  Copyright © 2020 村尾慶伸. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        TabView {
            RecordView()
                .tabItem {
                    Image("battle")
                        .renderingMode(.template)
                    Text("記録")
            }
            NoteView()
                .tabItem {
                    Image(systemName: "square.and.pencil")
                    Text("メモ")
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
