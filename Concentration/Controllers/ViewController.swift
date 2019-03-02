//
//  ViewController.swift
//  Concentration
//
//  Created by Ales Shenshin on 27/02/2019.
//  Copyright © 2019 Ales Shenshin. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    private lazy var game: Concentration = Concentration(numberOfPairsOfCards: numberOfPairsOfCards)

    private(set) var flipCount: Int = 0 {
        didSet {
            flipsLabel.text = "Flips: \(flipCount)"
        }
    }

    var numberOfPairsOfCards: Int {
        return (cardButtons.count+1)/2
    }

    private var emoji: Emoji!

    @IBOutlet private var cardButtons: [CardButton]!
    @IBOutlet private weak var flipsLabel: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
        startNewGame()
        print(5.arc4random)
    }

    @IBAction private func touchCard(_ sender: CardButton) {
        guard let cardNumber = cardButtons.firstIndex(of: sender) else {print("Card not found"); return}
        game.chooseCard(at: cardNumber)
        updateViewsFromModel()
        flipCount += 1
    }

    @IBAction private func newGameButtonPressed(_ sender: UIButton) {
        startNewGame()
    }

    func startNewGame() {
        emoji = Emoji(setTheme: .halloween)
        flipCount = 0
        game.startNewGame()
        updateViewsFromModel()
    }

    private func updateViewsFromModel() {
        for index in cardButtons.indices {
            let button = cardButtons[index]
            let card = game.cards[index]
            if card.isFaceUp {
                button.setTitle(emoji.getItem(forId: card.identifier), for: .normal)
                button.backgroundColor = .white
            } else {
                button.setTitle("", for: .normal)
                button.backgroundColor = card.isMatched ? .clear : .orange
            }
        }
    }
}

extension Int {
    var arc4random: Int {
        return Int(arc4random_uniform(UInt32(self)))
    }
}
