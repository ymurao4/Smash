//
//  FrameView.swift
//  Smash
//
//  Created by 村尾慶伸 on 2020/07/21.
//  Copyright © 2020 村尾慶伸. All rights reserved.
//

import SwiftUI

struct Kind: Identifiable {
    var id: Int
    var name: String
    var fileName: String
}

struct FrameView: View {
    
    @Environment (\.colorScheme) var colorScheme: ColorScheme
    @State private var isSheet: Bool = false
    @State private var selectedIndex: Int = 0
    let column = GridItem(.flexible(minimum: 60, maximum: 80))
    @State private var isPresented: Bool = false
    @State private var fighterName: String = ""
    
    var body: some View {
        
        NavigationView{
            
            List {
                
                ForEach(S.frameFighterArray, id: \.self) { item in
                    
                    HStack(spacing: 30) {
                        
                        Button(action: {
                            
                            self.fighterName = item
                            self.isPresented = true
                        }) {
                            
                            FighterPNG(name: item)
                                .frame(width: 70, height: 70)
                        }
                        
                        Text(T.translateFighterName(name: item))
                            .font(.title2)
                    }
                }
            }
            .navigationBarTitle("Frame".localized)
            .fullScreenCover(isPresented: $isPresented) {
                
                SafariView(fighterName: self.$fighterName)
            }
        }
    }
}

struct FrameView_Previews: PreviewProvider {
    static var previews: some View {
        FrameView()
    }
}

