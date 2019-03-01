//
//  CardButton.swift
//  Concentration
//
//  Created by Ales Shenshin on 28/02/2019.
//  Copyright © 2019 Ales Shenshin. All rights reserved.
//

import UIKit

class CardButton: UIButton {
    override func draw(_ rect: CGRect) {
        self.layer.cornerRadius = 16
        self.layer.masksToBounds = true
    }
}
