//
//  RecordVIew.swift
//  Smash
//
//  Created by 村尾慶伸 on 2020/07/20.
//  Copyright © 2020 村尾慶伸. All rights reserved.
//

import SwiftUI

struct RecordView: View {

    let testData = testDatas

    var body: some View {
        NavigationView{
            List{
                ForEach(testData) { data in
                    HStack(spacing: 30) {
                        Text(data.result)
                            .frame(maxWidth: .infinity)
                        PDF(name: data.myFighter)
                            .frame(width: 40, height: 40)
                        Text("vs")
                        PDF(name: data.opponentFighter)
                            .frame(width: 40, height: 40)
                        Text(data.stage)
                            .frame(maxWidth: .infinity)
                    }
                }
            }
            .navigationBarTitle("Record")
        }
    }
}

struct RecordVIew_Previews: PreviewProvider {
    static var previews: some View {
        RecordView()
    }
}
