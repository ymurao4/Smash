//
//  FrameView.swift
//  Smash
//
//  Created by 村尾慶伸 on 2020/07/21.
//  Copyright © 2020 村尾慶伸. All rights reserved.
//

import SwiftUI

struct FrameView: View {
    
    @Environment (\.colorScheme) var colorScheme: ColorScheme
    @State private var isPresented: Bool = false
    @State private var isGrid: Bool = false
    @State private var fighterName: String = ""
    
    var body: some View {
        
        NavigationView{
            
            VStack {
                
//                ListView(fighterName: $fighterName, isPresented: $isPresented)
                GridView()
                    .fullScreenCover(isPresented: $isPresented) {
                        
                        SafariView(fighterName: self.$fighterName)
                    }
            }
            .navigationBarTitle("Frame".localized)

        }
    }
}

struct FrameView_Previews: PreviewProvider {
    static var previews: some View {
        FrameView()
    }
}

struct ListView: View {
    
    @Binding var fighterName: String
    @Binding var isPresented: Bool
    
    var body: some View {
        
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
    }
}

struct GridView: View {
    
    let column = GridItem(.flexible(minimum: 60, maximum: 80))
    
    var body: some View {
        
        ScrollView(showsIndicators: false) {
            
            LazyVGrid(columns: Array(repeating: column, count: 4), spacing: 10) {
                
                ForEach(S.frameFighterArray, id: \.self) { item in
                    
                    FighterPNG(name: item)
                        .frame(width: 80, height: 80)
                }
            }
        }
    }
}
