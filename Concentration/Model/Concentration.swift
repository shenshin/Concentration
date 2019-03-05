//
//  Concentration.swift
//  Concentration
//
//  Created by Ales Shenshin on 27/02/2019.
//  Copyright © 2019 Ales Shenshin. All rights reserved.
//

import Foundation

struct Concentration {

    private(set) var cards: [Card] = []

    private let numberOfPairsOfCards: Int

    //индекс одной и только одной перевёрнутой вверх карты
    private var indexOfOneAndOnlyFaceUpCard: Int? {

        get {
            return cards.firstIndex(of: cards.filter{$0.isFaceUp}.oneAndOnly()!)
//            var foundIndex: Int?
//            for index in cards.indices where cards[index].isFaceUp {
//                if foundIndex == nil {
//                    foundIndex = index
//                } else {
//                    return nil
//                }
//            }
//            return foundIndex
        }
        set {
            for index in cards.indices {
                cards[index].isFaceUp = (index == newValue)
            }
        }
    }

    init(numberOfPairsOfCards: Int) {
        self.numberOfPairsOfCards = numberOfPairsOfCards
        startNewGame()
    }

    mutating func chooseCard(at index: Int) {
        assert(cards.indices.contains(index), "Concentration.chooseCard(at:\(index)): chosen index is not in the cards")
        //если карта не помечена как угаданная
        if !cards[index].isMatched {
            //если одна карта уже перевёрнута и это не текущая карта
            if let matchIndex = indexOfOneAndOnlyFaceUpCard, matchIndex != index {
                //проверить, совпадают ли текущая карта и перевёрнутая
                if cards[index] == cards[matchIndex] {
                    //пометить перевёрнутую карту и текущую как совпадающие
                    cards[matchIndex].isMatched = true
                    cards[index].isMatched = true
                    //скрыть перевёрнутую карту и текущую - это уже работа контроллера
                }
                cards[index].isFaceUp = true
            } else {
                indexOfOneAndOnlyFaceUpCard = index
            }
        }
    }

    mutating func startNewGame() {
        cards.removeAll()
        for _ in 1 ... numberOfPairsOfCards {
            let card = Card()
            cards += [card, card]
        }
        //тасую карты стандартной функцией перетасовки массива
        cards.shuffle()
    }
}
