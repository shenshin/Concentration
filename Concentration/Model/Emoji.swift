//
//  Emoji.swift
//  Concentration
//
//  Created by Ales Shenshin on 02/03/2019.
//  Copyright © 2019 Ales Shenshin. All rights reserved.
//

import Foundation

struct Emoji {

    private var emojiString = ""
    private var emoji: [Card: String] = [:]

    enum EmojiTheme: String, CaseIterable {
        case halloween = "🦇🧟‍♂️🧛🏻‍♂️💀🎃👻😈👾🧙🏼‍♀️"
        case sports = "⚽️🏀🏈🎾🎱🥊🥋⛸🏹🎿🏂⛳️🏊🏻‍♂️"
        case animals = "🐶🐱🐭🐹🐰🦊🐻🐼🐨🐯🦁🐮🐷"
        case people = "👩🏻‍🌾🧕🏾👮🏼‍♂️👷🏻‍♂️👨🏼‍⚕️👨🏻‍🍳👨🏼‍💻👨🏼‍🏫🕵🏻‍♂️👩🏻‍🔬👩🏻‍🎨👨🏻‍🚒👨🏼‍✈️"
        case flyingAnimals = "🐔🐧🐤🦆🦅🦉🦇🦟🦜🦢🕊🦋🐝"
        case letters = "ABCDEFGHIJKLMNOPQRSTUVWXYZ"
        case numbers = "1234567890!@#$%&*+-"

        static var random: EmojiTheme {
            return EmojiTheme.allCases.randomElement() ?? .halloween
        }
    }

    init(setTheme theme: EmojiTheme = .random) {
        emojiString = theme.rawValue
    }

    mutating func getCardItem(for card: Card) -> String {
        if emoji[card] == nil, emojiString.count > 0 {
            let randomStringIndex = emojiString.index(emojiString.startIndex,
                                                      offsetBy: emojiString.count.arc4random)
            emoji[card] = String(emojiString.remove(at: randomStringIndex))
        }
        return emoji[card] ?? "@"
    }
}
