//
//  ViewController.swift
//  Concentration
//
//  Created by Ales Shenshin on 27/02/2019.
//  Copyright © 2019 Ales Shenshin. All rights reserved.
//

import UIKit
import CoreLocation

class ConcentrationViewController: UIViewController {

    var theme: String? {
        didSet {
            updateTheme()
            updateViewsFromModel()
        }
    }
    private var emojiChoices: String!
    //чтобы при смене темы менялись уже показанные карты, нужно заменить карты в этом массиве
    private var emoji = [Card: String]() {
        didSet {
            print(emoji)
        }
    }
    private func emoji(for card: Card) -> String {
        if emoji[card] == nil, emojiChoices.count > 0 {
            let randomStringIndex = emojiChoices.index(emojiChoices.startIndex,
                                                      offsetBy: emojiChoices.count.arc4random)
            emoji[card] = String(emojiChoices.remove(at: randomStringIndex))
        }
        return emoji[card] ?? "?"
    }
//
//
//
    private lazy var game: Concentration = Concentration(numberOfPairsOfCards: numberOfPairsOfCards)

    var numberOfPairsOfCards: Int {
        return (cardButtons.count+1)/2
    }

    //private var emoji: Emoji!

    @IBOutlet weak var newGameButton: UIButton! {
        didSet {
            let attributes: [NSAttributedString.Key: Any] = [
                .strokeWidth: 4.0,
                .strokeColor: UIColor.white
            ]
            let attString = NSAttributedString(string: " New Game ", attributes: attributes)
            newGameButton.setAttributedTitle(attString, for: .normal)
            newGameButton.backgroundColor = .blue
        }
    }
    @IBOutlet private var cardButtons: [CardButton]!
    @IBOutlet private weak var flipsLabel: UILabel!
    @IBOutlet private weak var scoreLabel: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
        game.delegate = self
        startNewGame()
    }

    @IBAction private func touchCard(_ sender: CardButton) {
        guard let cardNumber = cardButtons.firstIndex(of: sender) else {print("Card not found"); return}
        game.chooseCard(at: cardNumber)
        updateViewsFromModel()
    }

    @IBAction private func newGameButtonPressed(_ sender: UIButton) {
        startNewGame()
    }

    func startNewGame() {
        //emoji = Emoji(setTheme: .halloween)
        //emoji.removeAll()
        updateTheme()
        game.startNewGame()
        updateViewsFromModel()
    }
    private func updateTheme() {
        if let themeString = theme {
            emojiChoices = themeString
        } else {
            emojiChoices = "🦇🧟‍♂️🧛🏻‍♂️💀🎃👻😈👾🧙🏼‍♀️"
        }
    }
    private func updateViewsFromModel() {
        if cardButtons != nil {
            for index in cardButtons.indices {
                let button = cardButtons[index]
                let card = game.cards[index]
                if card.isFaceUp {
                    button.setTitle(emoji(for: card), for: .normal)
                    //button.setTitle(emoji.getCardItem(for: card), for: .normal)
                    button.backgroundColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
                } else {
                    button.setTitle("", for: .normal)
                    button.backgroundColor = card.isMatched ? .clear : .blue
                }
            }
        }
    }
}

extension ConcentrationViewController: ConcentrationDelegate {
    func scoreChanged(to value: Int) {
        makeAttributed(string: "\(value) :Score", for: scoreLabel)
    }

    func flipsChanged(to flips: UInt8) {
        makeAttributed(string: "Flips: \(flips)", for: flipsLabel)
    }

    private func makeAttributed(string: String, for label: UILabel) {
        let attributes: [NSAttributedString.Key: Any] = [
            .strokeWidth: 5.0,
            .strokeColor: UIColor.blue
        ]
        let attString = NSAttributedString(string: string, attributes: attributes)
        label.attributedText = attString
    }
}
