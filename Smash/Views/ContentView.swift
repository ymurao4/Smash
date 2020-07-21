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
        VStack(spacing: 0) {
            ZStack {
                if self.index == 0 {
                    RecordView()
                } else if self.index == 1 {
                    AnalysisView()
                } else if self.index == 2 {
                    FrameView()
                } else {
                    NoteView()
                }
            }
            .padding(.bottom, -35)
            CustomTabs(index: $index)
        }
        .background(Color(UIColor.tertiarySystemGroupedBackground).edgesIgnoringSafeArea(.bottom))
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

        HStack {
            // 記録
            Button(action: {
                self.index = 0
            }) {
                VStack {
                    Image("battle")
                        .renderingMode(.template)
                    Text("記録")
                        .font(.caption)
                }
            }
            .foregroundColor(Color.backgroundColor(for: colorScheme).opacity(self.index == 0 ? 1 : 0.5))
            .padding(.top, 10)
            Spacer(minLength: 0)

            // 分析
            Button(action: {
                self.index = 1
            }) {
                VStack {
                    Image("analysis")
                        .renderingMode(.template)
                    Text("分析")
                        .font(.caption)
                }
            }
            .foregroundColor(Color.backgroundColor(for: colorScheme).opacity(self.index == 1 ? 1 : 0.5))
            .padding(.top, 10)
            Spacer(minLength: 0)

            // 追加
            Button(action: {

            }) {
                Image(systemName: "plus")
                    .font(.system(size: 25))
                    .foregroundColor(.white)
                    .frame(width: 54, height: 54)
                    .background(Color.accentColor)
                    .cornerRadius(27)
            }
            .offset(y: -27)
            Spacer(minLength: 0)

            // フレーム
            Button(action: {
                self.index = 2
            }) {
                VStack {
                    Image(systemName: "square.grid.2x2")
                        .font(.system(size: 20))
                    Text("フレ")
                        .font(.caption)
                }
            }
            .foregroundColor(Color.backgroundColor(for: colorScheme).opacity(self.index == 2 ? 1 : 0.5))
            .padding(.top, 10)
            Spacer(minLength: 0)

            // メモ
            Button(action: {
                self.index = 3
            }) {
                VStack {
                    Image(systemName: "square.and.pencil")
                        .font(.system(size: 20))
                    Text("メモ")
                        .font(.caption)
                }
            }
            .foregroundColor(Color.backgroundColor(for: colorScheme).opacity(self.index == 3 ? 1 : 0.5))
            .padding(.top, 10)
        }
        .padding(.horizontal, 35)
        .padding(.top, 35)
        .background(Color(UIColor.tertiarySystemGroupedBackground))
        .clipShape(CShape())
    }

}

struct CShape: Shape {

    func path(in rect: CGRect) -> Path {
        return Path { path in
            path.move(to: CGPoint(x: 0, y: 35))
            path.addLine(to: CGPoint(x: 0, y: rect.height))
            path.addLine(to: CGPoint(x: rect.width, y: rect.height))
            path.addLine(to: CGPoint(x: rect.width, y: 35))

            path.addArc(center: CGPoint(x: (rect.width / 2) + 2, y: 35), radius: 35, startAngle: .zero, endAngle: .init(degrees: 180), clockwise: true)
        }
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
}
