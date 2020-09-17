//
//  String.swift
//  Smash
//
//  Created by 村尾慶伸 on 2020/09/17.
//  Copyright © 2020 村尾慶伸. All rights reserved.
//

import Foundation

extension String {
  var localized: String {
    return NSLocalizedString(self, comment: "")
  }
}
