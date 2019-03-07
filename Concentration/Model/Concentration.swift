//
//  Concentration.swift
//  Concentration
//
//  Created by Ales Shenshin on 27/02/2019.
//  Copyright © 2019 Ales Shenshin. All rights reserved.
//

import Foundation

protocol ConcentrationDelegate: class {
    func flipsChanged(to flips: UInt8)
    func scoreChanged(to value: Int)
}

struct Concentration {
    //будет увеличиваться на 2 при совпадении карт
    var score: Int = 0 {
        didSet {
            delegate?.scoreChanged(to: score)
        }
    }

    weak var delegate: ConcentrationDelegate?

    private var flips: UInt8 = .zero {
        didSet {
            delegate?.flipsChanged(to: flips)
        }
    }

    private(set) var cards: [Card] = []
    var shownCards: [Card] = []

    private let numberOfPairsOfCards: Int

    //индекс одной и только одной перевёрнутой вверх карты
    private var indexOfOneAndOnlyFaceUpCard: Int? {

        get {
            return cards.indices.filter {cards[$0].isFaceUp}.oneAndOnlyElement()
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
        assert(cards.indices.contains(index),
               "Concentratión.chooseCard(at:\(index)): chósen index is not in the cards")

        //помещаю все показанные однажды карты в отдельный массив shownCards

        //если карта не помечена как угаданная. Всё происходит именно при этом
        //условии, потому что иначе карты "удалены" из колоды вьюконтроллером
        if !cards[index].isMatched {
            flips += 1
            //если одна карта уже перевёрнута и это не текущая карта
            if let matchIndex = indexOfOneAndOnlyFaceUpCard, matchIndex != index {
                //проверить, совпадают ли текущая карта и перевёрнутая
                if cards[index] == cards[matchIndex] {
                    //пометить перевёрнутую карту и текущую как совпадающие
                    cards[matchIndex].isMatched = true
                    cards[index].isMatched = true
                    score += 2
                    removeFromShownCards(cards[index])
                } else {
                //Если они не совпадают, проверить, была ли текущая карта или её близнец
                //уже однажды показаны, т.е. находится ли карта в массиве shownCards
                    updateScore(for: cards[index])
                //Если они не совпадают, пометить текущую как уже показанную
                    addToShownCards(cards[index])
                    //cards[index].isOnceShown = true
                    //cards[index].timesShown++
                }
                cards[index].isFaceUp = true
            //если ни одна карта не перевёрнута, пометить её как уже показанную
            //и присвоить ее индекс индексу единственной перевёрнутой карты
            } else {
                updateScore(for: cards[index])
                addToShownCards(cards[index])
                //cards[index].isOnceShown = true
                indexOfOneAndOnlyFaceUpCard = index
                //cards[index].timesShown++
            }
        }
    }
    private mutating func updateScore(for card: Card) {
        if shownCards.contains(card) {
            score--
        }
    }
//у меня есть информация о том, была ли показана текущая карта и была ли показана её пара
//    private mutating func isShown(card: Card) -> Bool {
//        if shownCards.contains(card) || card.isOnceShown {
//            return true
//        } else {
//            return false
//        }
//    }
    private mutating func addToShownCards(_ card: Card) {
        if !shownCards.contains(card) {
            shownCards.append(card)
        }
    }
    private mutating func removeFromShownCards(_ card: Card) {
        if let index = shownCards.firstIndex(of: card) {
            shownCards.remove(at: index)
        }
    }

    mutating func startNewGame() {
        cards.removeAll()
        flips = .zero
        score = 0
        for _ in 1 ... numberOfPairsOfCards {
            let card = Card()
            cards += [card, card]
        }
        //тасую карты стандартной функцией перетасовки массива
        cards.shuffle()
    }
}
