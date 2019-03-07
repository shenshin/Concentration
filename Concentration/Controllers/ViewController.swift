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

    var numberOfPairsOfCards: Int {
        return (cardButtons.count+1)/2
    }

    private var emoji: Emoji!

    @IBOutlet weak var newGameButton: UIButton! {
        didSet {
            let attributes: [NSAttributedString.Key: Any] = [
                .strokeWidth: 4.0,
                .strokeColor: UIColor.black
            ]
            let attString = NSAttributedString(string: " New Game ", attributes: attributes)
            newGameButton.setAttributedTitle(attString, for: .normal)
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
        emoji = Emoji(setTheme: .halloween)
        game.startNewGame()
        updateViewsFromModel()
    }

    private func updateViewsFromModel() {

        for index in cardButtons.indices {
            let button = cardButtons[index]
            let card = game.cards[index]
            if card.isFaceUp {
                button.setTitle(emoji.getCardItem(for: card), for: .normal)
                button.backgroundColor = .white
            } else {
                button.setTitle("", for: .normal)
                button.backgroundColor = card.isMatched ? .clear : .orange
            }
        }
    }
}

extension ViewController: ConcentrationDelegate {
    func scoreChanged(to value: Int) {
        let attributes: [NSAttributedString.Key: Any] = [
            .strokeWidth: 5.0,
            .strokeColor: UIColor.orange
        ]
        let attString = NSAttributedString(string: "\(value) :Score", attributes: attributes)
        scoreLabel.attributedText = attString
    }

    func flipsChanged(to flips: UInt8) {
            let attributes: [NSAttributedString.Key: Any] = [
                .strokeWidth: 5.0,
                .strokeColor: UIColor.orange
            ]
            let attString = NSAttributedString(string: "Flips: \(flips)", attributes: attributes)
            flipsLabel.attributedText = attString
    }
}
