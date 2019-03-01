//
//  Concentration.swift
//  Concentration
//
//  Created by Ales Shenshin on 27/02/2019.
//  Copyright © 2019 Ales Shenshin. All rights reserved.
//

import Foundation

class Concentration {

    var cards: [Card] = []

    //индекс одной и только одной перевёрнутой вверх карты
    var indexOfOneAndOnlyFaceUpCard: Int?

    init(numberOfPairsOfCards: Int) {
        Card.identifierFactory = 0
        for _ in 1 ... numberOfPairsOfCards {
            let card = Card()
            cards += [card, card]
        }
        //тасую карты стандартной функцией перетасовки массива
        cards.shuffle()
        //print(cards.map {$0.identifier}) //печатает элементы массива в строчку
        //cards.forEach {print($0.identifier)} //печатает элементы массива в столбик
    }
    func chooseCard(at index: Int) {
        //если карта не помечена как угаданная
        if !cards[index].isMatched {
            //если одна карта уже перевёрнута и это не текущая карта
            if let matchIndex = indexOfOneAndOnlyFaceUpCard, matchIndex != index {
                //проверить, совпадают ли текущая карта и перевёрнутая
                if cards[index].identifier == cards[matchIndex].identifier {
                    //пометить перевёрнутую карту и текущую как совпадающие
                    cards[matchIndex].isMatched = true
                    cards[index].isMatched = true
                    //скрыть перевёрнутую карту и текущую - это уже работа контроллера
                }
                cards[index].isFaceUp = true
                indexOfOneAndOnlyFaceUpCard = nil
            } else { //если нет перевёрнутых карт или их больше одной (2)
                //перевернуть все карты вниз
                for flipDownIndex in cards.indices {
                    cards[flipDownIndex].isFaceUp = false
                }
                //открыть только что выбранную карту
                cards[index].isFaceUp = true
                indexOfOneAndOnlyFaceUpCard = index
            }
        }
    }
}
