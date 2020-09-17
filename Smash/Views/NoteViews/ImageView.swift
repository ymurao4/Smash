//
//  ImageView.swift
//  Smash
//
//  Created by 村尾慶伸 on 2020/09/17.
//  Copyright © 2020 村尾慶伸. All rights reserved.
//

import SwiftUI

struct ImageView: View {

    var image: UIImage
    @State private var scale: CGFloat = 1.0
    @State private var pointTapped: CGPoint = CGPoint.zero
    @State private var draggedSize: CGSize = CGSize.zero
    @State private var previousDragged: CGSize = CGSize.zero

    var body: some View {

            GeometryReader { geo in

                Image(uiImage: image)
                    .resizable()
                    .scaledToFit()
                    .animation(.default)
                    .offset(x: draggedSize.width, y: draggedSize.height)
                    .scaleEffect(scale)
                    .gesture(TapGesture(count: 2).onEnded({

                        if scale == 1 {

                            withAnimation {

                                scale = 3
                            }
                        } else {

                            withAnimation {

                                scale = 1
                            }
                        }
                    })
                    .simultaneously(with: DragGesture(minimumDistance: 0, coordinateSpace: .global)
                                        .onChanged({ value in

                                            pointTapped = value.startLocation
                                            draggedSize = CGSize(width: value.translation.width + previousDragged.width, height: value.translation.height + previousDragged.height)
                                        })
                                        .onEnded({ value in

                                            let offsetWidth = (geo.frame(in: .global).maxX * scale - geo.frame(in: .global).maxX) / 2
                                            let newDraggedWidth = draggedSize.width * scale

                                            if newDraggedWidth > offsetWidth {

                                                draggedSize = CGSize(width: offsetWidth / scale, height: value.translation.height + previousDragged.height)
                                            } else if newDraggedWidth < -offsetWidth {

                                                draggedSize = CGSize(width: -offsetWidth / scale, height: value.translation.height + previousDragged.height)
                                            } else {

                                                draggedSize = CGSize(width: value.translation.width + previousDragged.width, height: value.translation.height + previousDragged.height)
                                            }

                                            previousDragged = draggedSize
                                        })))
                    .gesture(MagnificationGesture()
                                .onChanged({ scale in

                                    self.scale = scale.magnitude
                                }).onEnded({ scale in

                                    self.scale = scale.magnitude
                                }))
            }
    }
}

struct ImageView_Previews: PreviewProvider {
    static var previews: some View {
        ImageView(image: UIImage())
    }
}
