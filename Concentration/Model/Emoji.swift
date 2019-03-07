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

        static var random: EmojiTheme {
            return EmojiTheme.allCases[EmojiTheme.allCases.count.arc4random]
        }
    }

    init(setTheme theme: EmojiTheme = .random) {
        emojiString = theme.rawValue
    }

    mutating func getGardItem(for card: Card) -> String {
        if emoji[card] == nil, emojiString.count > 0 {
            let randomStringIndex = emojiString.index(emojiString.startIndex,
                                                      offsetBy: emojiString.count.arc4random)
            emoji[card] = String(emojiString.remove(at: randomStringIndex))
        }
        return emoji[card] ?? "@"
    }
}
