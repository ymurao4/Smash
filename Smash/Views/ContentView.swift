//
//  ContentView.swift
//  Smash
//
//  Created by 村尾慶伸 on 2020/07/20.
//  Copyright © 2020 村尾慶伸. All rights reserved.
//

import SwiftUI

struct ContentView: View {

    @State private var index: Int = 0

    var body: some View {
        /*
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
                .edgesIgnoringSafeArea(.horizontal)
                .edgesIgnoringSafeArea(.bottom)
        }
        */
        TabView() {

            RecordView()
                .tabItem {

                    VStack {

                        Image("battle")
                            .renderingMode(.template)

                        Text("記録")
                    }
            }
            AnalysisView()
                .tabItem {

                    VStack {

                        Image("analysis")
                            .renderingMode(.template)

                        Text("分析")
                    }
            }
            NoteView()
                .tabItem {
                    
                    VStack {

                        Image(systemName: "square.and.pencil")
                            .font(.system(size: 22))

                        Text("メモ")
                    }
            }
            FrameView()
                .tabItem {

                    VStack {

                        Image(systemName: "text.justify")
                            .font(.system(size: 22))

                        Text("情報")
                    }
            }
        }
        .accentColor(.orange)
            //　ここで宣言すると、tabbarを覆う
            .addPartialSheet()
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

    @Environment (\.colorScheme) var colorScheme: ColorScheme
    @Binding var index: Int

    var body: some View {

        HStack(alignment: .top) {
            // 記録
            VStack(spacing: 8) {
                EdgeBorder(width: 6, edge: .top)
                    .frame(width: 40, height: 3)
                    .cornerRadius(1)
                    .foregroundColor(index == 0 ? Color.gray : Color.reverseBackgroundColor(for: colorScheme))
                Button(action: {
                    self.index = 0
                }) {
                    Image("battle")
                        .renderingMode(.template)
                }
                .foregroundColor(index == 0 ? Color.gray : Color.backgroundColor(for: colorScheme))
            }
            .padding(.top, -13)
            Spacer(minLength: 0)

            // 分析
            VStack(spacing: 8) {
                EdgeBorder(width: 6, edge: .top)
                    .frame(width: 40, height: 3)
                    .cornerRadius(1)
                    .foregroundColor(index == 1 ? Color.gray : Color.reverseBackgroundColor(for: colorScheme))
                Button(action: {
                    self.index = 1
                }) {
                    Image("analysis")
                        .renderingMode(.template)
                }
                .foregroundColor(index == 1 ? Color.gray : Color.backgroundColor(for: colorScheme))
            }
            .padding(.top, -13)
            Spacer(minLength: 0)

            // メモ
            VStack(spacing: 12) {
                EdgeBorder(width: 6, edge: .top)
                    .frame(width: 40, height: 3)
                    .cornerRadius(1)
                    .foregroundColor(index == 2 ? Color.gray : Color.reverseBackgroundColor(for: colorScheme))
                Button(action: {
                    self.index = 2
                }) {
                    Image(systemName: "square.and.pencil")
                        .font(.system(size: 22))
                }
                .foregroundColor(index == 2 ? Color.gray : Color.backgroundColor(for: colorScheme))
            }
            .padding(.top, -13)
            Spacer(minLength: 0)

            // フレーム
            VStack(spacing: 14) {
                EdgeBorder(width: 6, edge: .top)
                    .frame(width: 40, height: 3)
                    .cornerRadius(1)
                    .foregroundColor(index == 3 ? Color.gray : Color.reverseBackgroundColor(for: colorScheme))
                Button(action: {
                    self.index = 3
                }) {
                    Image(systemName: "text.justify")
                        .font(.system(size: 22))
                }
                .foregroundColor(index == 3 ? Color.gray : Color.backgroundColor(for: colorScheme))
            }
            .padding(.top, -13)
        }
        .padding(EdgeInsets(top: 15, leading: 35, bottom: 10, trailing: 35))
        .cornerRadius(8)
        .frame(width: UIScreen.main.bounds.width * 0.95)
        .border(Color(UIColor.tertiarySystemGroupedBackground), width: 2)
        .background(Color.reverseBackgroundColor(for: colorScheme))
        .shadow(color: Color(UIColor.systemGray3), radius: 8, x: 0, y: 12)
    }

}


