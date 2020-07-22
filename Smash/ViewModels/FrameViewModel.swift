//
//  FrameViewModel.swift
//  Smash
//
//  Created by 村尾慶伸 on 2020/07/22.
//  Copyright © 2020 村尾慶伸. All rights reserved.
//

import Foundation
import Combine

class FrameViewModel: ObservableObject {

//    @Published var frame: Frame
//    @Published var fighterName: String = "wario"

    var csvLines = [String]()

    func loadData() {
        guard let path = Bundle.main.path(forResource: "csv/wario", ofType: "csv") else {
            return
        }

        do {
            let csvString = try String(contentsOfFile: path, encoding: String.Encoding.utf8)
            csvLines = csvString.components(separatedBy: "\n")
            print(csvLines)
        } catch {
            print("Error")
        }


    }

}
