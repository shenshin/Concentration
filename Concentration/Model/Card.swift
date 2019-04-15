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
    var isOnceShown = false

    private var identifier: UInt64

    private static var identifierFactory: UInt64 = 0
    //инициализаторы должны иметь одно имя для внутренних и внешних
    //параметров
    init() {
        self.identifier = Card.getUniqueIdentifier()
    }

    private static func getUniqueIdentifier() -> UInt64 {
        identifierFactory += 1
        return identifierFactory
    }
}
//без этих двух функций ничего работать не будет!!!
//Хотя считается, что структуры со свойствами, представленными типами,
//реализующими Hashable, являются Hashable автоматически, и реализовывать
//нижеприведённые методы не обязательно, тем не менее, без них программа
//не работает!
extension Card: Hashable {
    func hash(into hasher: inout Hasher) {
        hasher.combine(self.identifier)
    }

    static func == (lhs: Card, rhs: Card) -> Bool {
        return lhs.identifier == rhs.identifier
    }
}

extension Card: CustomStringConvertible {
    var description: String {
        return "Card№\(identifier): Is Face Up - \(isFaceUp), Is Matched: \(isMatched), Is Once Shown: \(isOnceShown)"
    }
}
