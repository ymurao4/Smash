//
//  InformationView.swift
//  Smash
//
//  Created by 村尾慶伸 on 2020/07/31.
//  Copyright © 2020 村尾慶伸. All rights reserved.
//

import SwiftUI
import WaterfallGrid

struct Kind: Hashable {
    var id: Int
    var jaName: String
    var fileName: String
}

struct InformationView: View {
    private let kindRaniking = [["フレーム表", "Frame"], ["空中加速", "AirAcceleration"], ["空中移動", "AirSpeed"], ["落下", "FallSpeed"], ["ダッシュ", "DashSpeed"], ["歩行", "WalkSpeed"], ["走行", "RunSpeed"], ["重量", "Weight"]]

    @State var kinds: [Kind] = [
        Kind(id: 0, jaName: "フレーム", fileName: "Frame"),
        Kind(id: 1, jaName: "空中加速", fileName: "AirAcceleration"),
        Kind(id: 2, jaName: "空中移動", fileName: "AirSpeed"),
        Kind(id: 3, jaName: "落下", fileName: "FallSpeed"),
        Kind(id: 4, jaName: "ダッシュ", fileName: "DashSpeed"),
        Kind(id: 5, jaName: "歩行", fileName: "WalkSpeed"),
        Kind(id: 6, jaName: "走行", fileName: "RunSpeed"),
        Kind(id: 7, jaName: "重量", fileName: "Weight")
    ]

    var body: some View {
        NavigationView {

            ScrollView(.vertical) {
                ForEach(0..<self.kindRaniking.count, id: \.self) { index in
                    NavigationLink(destination: Group {
                        if index == 0 {
                            FrameView()
                        } else {
                            RankingView(rankingName: self.kindRaniking[index])
                        }
                    }) {
                        VStack {
                            Image(self.kindRaniking[index][1])
                                .renderingMode(.original)
                                .resizable()
                                .scaledToFit()
                                .mask(CustomShape(radius: 20))
                            Text(self.kindRaniking[index][0])
                                .font(.headline)
                                .padding(.bottom, 5)
                        }
                            // cornerradiusだと角が削れる
                            .overlay(
                                RoundedRectangle(cornerRadius: 20)
                                    .stroke(Color.orange, lineWidth: 3)
                        )
                    }
                    .padding(.horizontal, 20)
                }
            }
            .navigationBarTitle(Text("一覧"), displayMode: .large)
        }
    }
}

struct InformationView_Previews: PreviewProvider {
    static var previews: some View {
        InformationView()
    }
}

// 画像の上だけradius
struct CustomShape: Shape {
    let radius: CGFloat

    func path(in rect: CGRect) -> Path {
        var path = Path()
        
        let tls = CGPoint(x: rect.minX, y: rect.minY + radius)
        let tlc = CGPoint(x: rect.minX + radius, y: rect.minY + radius)
        let trs = CGPoint(x: rect.maxX - radius, y: rect.minY)
        let trc = CGPoint(x: rect.maxX - radius, y: rect.minY + radius)
        let br = CGPoint(x: rect.maxX, y: rect.maxY)
        let bl = CGPoint(x: rect.minX, y: rect.maxY)


        
        // Do stuff here to draw the outline of the mask
        path.move(to: tls)
        path.addRelativeArc(center: tlc, radius: radius, startAngle: Angle.degrees(180), delta: Angle.degrees(90))
        path.addLine(to: trs)
        path.addRelativeArc(center: trc, radius: radius, startAngle: Angle.degrees(270), delta: Angle.degrees(90))
        path.addLine(to: br)
        path.addLine(to: bl)

        return path
    }
}
