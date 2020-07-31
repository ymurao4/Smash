//
//  InformationView.swift
//  Smash
//
//  Created by 村尾慶伸 on 2020/07/31.
//  Copyright © 2020 村尾慶伸. All rights reserved.
//

import SwiftUI
import WaterfallGrid

struct InformationView: View {

    private let kindRaniking = [["空中加速", "AirAcceleration"], ["空中移動", "AirSpeed"], ["落下", "FallSpeed"], ["ダッシュ", "DashSpeed"], ["歩行", "WalkSpeed"], ["走行", "RunSpeed"], ["重量", "Weight"], ["フレーム表", "Frame"]]

    var body: some View {
        NavigationView {
            WaterfallGrid(0..<kindRaniking.count, id: \.self) { index in
                NavigationLink(destination: Group {
                    if index != 7 {
                        RankingView(rankingName: self.kindRaniking[index])
                    } else {
                        FrameView()
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
            }
            .gridStyle(columns: 2, spacing: 10, padding: EdgeInsets(top: 10, leading: 10, bottom: 60, trailing: 10), animation: .easeOut(duration: 0.3))
            .scrollOptions(direction: .vertical, showsIndicators: false)
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
