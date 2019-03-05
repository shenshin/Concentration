//
//  Extensions.swift
//  Concentration
//
//  Created by Ales Shenshin on 05/03/2019.
//  Copyright © 2019 Ales Shenshin. All rights reserved.
//

import Foundation

extension Int {
    var arc4random: Int {
        return Int(arc4random_uniform(UInt32(self)))
    }
}

extension Collection {
    func oneAndOnly() -> Element? {
        return self.count == 1 ? self.first : nil
    }
}
