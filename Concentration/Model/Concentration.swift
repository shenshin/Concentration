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

    weak var delegate: ConcentrationDelegate?
    //счёт игры: увеличивается на 2 при совпадении 2-х карт и
    //уменьшается на 1 если выбрана уже ранее показанная карта
    var score: Int = 0 {
        didSet {
            delegate?.scoreChanged(to: score)
        }
    }

    private var flips: UInt8 = .zero {
        didSet {
            delegate?.flipsChanged(to: flips)
        }
    }

    private(set) var cards: [Card] = []
    private var previouslyShownCard: Card?
//    var shownCards: [Card] = []

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
        //если карта не помечена как угаданная: Всё происходит именно при этом
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
                } else {
                    decreaseScore(for: cards[index])
                    cards[index].isOnceShown = true
                }
                cards[index].isFaceUp = true
            //если ни одна карта не перевёрнута, пометить её как уже показанную
            //и присвоить ее индекс индексу единственной перевёрнутой карты
            } else {
                decreaseScore(for: cards[index])
                cards[index].isOnceShown = true

                indexOfOneAndOnlyFaceUpCard = index
            }
        }
        previouslyShownCard = cards[index]
    }

    private mutating func decreaseScore(for card: Card) {
        if card.isOnceShown {
            score--
            if previouslyShownCard == card {
                score++
            }
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
