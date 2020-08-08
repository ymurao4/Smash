//
//  CornerRadiusOnlyTop.swift
//  Smash
//
//  Created by 村尾慶伸 on 2020/08/04.
//  Copyright © 2020 村尾慶伸. All rights reserved.
//

import Foundation
import SwiftUI

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
