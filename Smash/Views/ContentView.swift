//
//  ContentView.swift
//  Smash
//
//  Created by 村尾慶伸 on 2020/07/20.
//  Copyright © 2020 村尾慶伸. All rights reserved.
//

import SwiftUI

struct ContentView: View {

    @State var index = 0

    var body: some View {
        ZStack(alignment: .bottom) {
            if self.index == 0 {
                RecordView()
            } else if self.index == 1 {
                AnalysisView()
            } else if self.index == 2 {
                NoteView()
            } else {
                FrameView()
            }
            CustomTabs(index: $index)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            ContentView()
                .environment(\.colorScheme, .light)
            ContentView()
                .environment(\.colorScheme, .dark)
        }

    }
}

struct CustomTabs: View {

    @Environment (\.colorScheme) var colorScheme:ColorScheme
    @Binding var index: Int

    var body: some View {

        HStack(alignment: .lastTextBaseline) {
            // 記録
            Button(action: {
                self.index = 0
            }) {
                Image("battle")
                    .renderingMode(.template)
            }
            .foregroundColor(Color.backgroundColor(for: colorScheme).opacity(self.index == 0 ? 1 : 0.45))
            Spacer(minLength: 0)

            // 分析
            Button(action: {
                self.index = 1
            }) {
                Image("analysis")
                    .renderingMode(.template)
            }
            .foregroundColor(Color.backgroundColor(for: colorScheme).opacity(self.index == 1 ? 1 : 0.45))
            Spacer(minLength: 0)

            // メモ
            Button(action: {
                self.index = 2
            }) {
                Image(systemName: "square.and.pencil")
                    .font(.system(size: 20))
                    .padding(.bottom, 8)
            }
            .foregroundColor(Color.backgroundColor(for: colorScheme).opacity(self.index == 2 ? 1 : 0.45))
            Spacer(minLength: 0)

            // フレーム
            Button(action: {
                self.index = 3
            }) {
                Image(systemName: "line.horizontal.3")
                    .font(.system(size: 20))
                    .padding(.bottom, 8)
            }
            .foregroundColor(Color.backgroundColor(for: colorScheme).opacity(self.index == 3 ? 1 : 0.45))
        }
        .padding(EdgeInsets(top: 15, leading: 35, bottom: 10, trailing: 35))
        .frame(width: UIScreen.main.bounds.width * 0.95)
        .border(Color(UIColor.tertiarySystemGroupedBackground), width: 2)
        .cornerRadius(5)
        .background(Color.tabBackgroundColor(for: colorScheme))
        .shadow(color: Color(UIColor.systemGray3), radius: 8, x: 0, y: 12)
    }

}

extension Color {
    static let black = Color.black
    static let white = Color.white

    static func backgroundColor(for colorScheme: ColorScheme) -> Color {
        if colorScheme == .dark {
            return white
        } else {
            return black
        }
    }

    static func tabBackgroundColor(for colorScheme: ColorScheme) -> Color {
        if colorScheme == .dark {
            return black
        } else {
            return white
        }
    }
}
