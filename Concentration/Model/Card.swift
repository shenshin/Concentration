//
//  Card.swift
//  Concentration
//
//  Created by Ales Shenshin on 27/02/2019.
//  Copyright © 2019 Ales Shenshin. All rights reserved.
//

import Foundation
//Важно, чтобы внутри сущностей модели не было НИКАКИХ данных о внешнем виде!
//Никаких картинок
struct Card {
    var isFaceUp = false
    var isMatched = false
    var identifier: Int

    static var identifierFactory = 0
    //инициализаторы должны иметь одно имя для внутренних и внешних
    //параметров
    init() {
        self.identifier = Card.getUniqueIdentifier()
    }

    static func getUniqueIdentifier() -> Int {
        identifierFactory += 1
        return identifierFactory
    }
}
