//
//  InformationView.swift
//  Smash
//
//  Created by 村尾慶伸 on 2020/07/31.
//  Copyright © 2020 村尾慶伸. All rights reserved.
//

import SwiftUI
import WaterfallGrid

struct Kind: Identifiable {
    var id: Int
    var jaName: String
    var fileName: String
}

struct InformationView: View {

    // あとで消す
    @State private var kinds: [Kind] = [
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
            ScrollView(.vertical, showsIndicators: false) {
                VStack {
                    ForEach(kinds) { kind in
                        GeometryReader { geometry in
                            CardView(kind: kind)
                            .rotation3DEffect(Angle(degrees:
                                (Double(geometry.frame(in: .global).minY) - 350) / 12
                            ), axis: (x: 0, y: 10.0, z: 0))
                        }
                        .frame(width: UIScreen.main.bounds.width * 0.9, height: 200)
                    }
                }
                .padding(EdgeInsets(top: 40, leading: 30, bottom: 70, trailing: 30))
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

struct  CardView: View {

    var kind: Kind

    var body: some View {
        NavigationLink(destination: Group {
            if kind.id == 0 {
                FrameView()
            } else {
                RankingView(kind: kind)
            }
        }) {
            VStack {
                Image(kind.fileName)
                    .renderingMode(.original)
                    .resizable()
                    .scaledToFit()
                    .mask(CustomShape(radius: 20))
                Text(kind.jaName)
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
