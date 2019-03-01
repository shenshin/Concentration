//
//  ViewController.swift
//  Concentration
//
//  Created by Ales Shenshin on 27/02/2019.
//  Copyright © 2019 Ales Shenshin. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    var game: Concentration!
    var flips: Int = 0 {
        didSet {
            flipsLabel.text = "Flips: \(flips)"
        }
    }
    var emojiChoices = [String]()
    var emoji = [Int: String]()

    @IBOutlet var cardButtons: [CardButton]!
    @IBOutlet weak var flipsLabel: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
        startNewGame()
    }

    @IBAction func touchCard(_ sender: CardButton) {
        guard let cardNumber = cardButtons.firstIndex(of: sender) else {print("Card not found"); return}
        game.chooseCard(at: cardNumber)
        updateViewsFromModel()
        flips += 1
    }

    @IBAction func newGameButtonPressed(_ sender: UIButton) {
        startNewGame()
    }

    func startNewGame() {
        emojiChoices = ["🦇", "🧟‍♂️", "🧛🏻‍♂️", "💀", "🎃", "👻", "😈", "👾", "🧙🏼‍♀️"]
        flips = 0
        emoji.removeAll()
        game = Concentration(numberOfPairsOfCards: cardButtons.count/2)
        updateViewsFromModel()
    }

    func updateViewsFromModel() {
        for index in cardButtons.indices {
            let button = cardButtons[index]
            let card = game.cards[index]
            if card.isFaceUp {
                button.setTitle(emoji(for: card), for: .normal)
                button.backgroundColor = .white
            } else {
                button.setTitle("", for: .normal)
                button.backgroundColor = card.isMatched ? .clear : .orange
            }
        }
    }

    func emoji(for card: Card) -> String {
        if emojiChoices.count > 0, emoji[card.identifier] == nil {
            let randomIndex = Int(arc4random_uniform(UInt32(emojiChoices.count)))
            emoji[card.identifier] = emojiChoices.remove(at: randomIndex)
        }
        return emoji[card.identifier] ?? "?"
    }
}
