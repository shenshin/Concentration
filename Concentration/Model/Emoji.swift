//
//  Emoji.swift
//  Concentration
//
//  Created by Ales Shenshin on 02/03/2019.
//  Copyright © 2019 Ales Shenshin. All rights reserved.
//

import Foundation

struct Emoji {
    private var emojiArray: [String] = []
    private var emojiString = ""
    private var emoji: [Card: String] = [:]

    enum EmojiTheme: CaseIterable {
        case halloween
        case sports
        case animals
        case people
        case flyingAnimals
        case letters

        static var random: EmojiTheme {
            return EmojiTheme.allCases[EmojiTheme.allCases.count.arc4random]
        }
    }

    init(setTheme theme: EmojiTheme) {
        emojiArray = setTheme(theme)
        //Joins an array of strings into a string (built in func)
        emojiString = emojiArray.joined()
        //emojiArray.shuffle()
    }

    private func setTheme(_ emojiTheme: EmojiTheme) -> [String] {
        switch emojiTheme {
        case .halloween:
            return ["🦇", "🧟‍♂️", "🧛🏻‍♂️", "💀", "🎃", "👻", "😈", "👾", "🧙🏼‍♀️"]
        case .animals:
            return ["🐶", "🐱", "🐭", "🐹", "🐰", "🦊", "🐻", "🐼", "🐨", "🐯", "🦁", "🐮", "🐷"]
        case .flyingAnimals:
            return ["🐔", "🐧", "🐤", "🦆", "🦅", "🦉", "🦇", "🦟", "🦜", "🦢", "🕊", "🦋", "🐝"]
        case .people:
            return ["👩🏻‍🌾", "🧕🏾", "👮🏼‍♂️", "👷🏻‍♂️", "👨🏼‍⚕️", "👨🏻‍🍳", "👨🏼‍💻", "👨🏼‍🏫", "🕵🏻‍♂️", "👩🏻‍🔬", "👩🏻‍🎨", "👨🏻‍🚒", "👨🏼‍✈️"]
        case .sports:
            return ["⚽️", "🏀", "🏈", "🎾", "🎱", "🥊", "🥋", "⛸", "🏹", "🎿", "🏂", "⛳️", "🏊🏻‍♂️"]
        case .letters:
            return ["A", "B", "C", "D", "E", "F", "G", "H", "I", "J", "K", "L", "M",
                    "N", "O", "P", "Q", "R", "S", "T", "U", "V", "W", "X", "Y", "Z"]
        }
    }

    func getItem(forId identifier: Int) -> String {
        return identifier < emojiArray.count ? emojiArray[identifier] : "?"
    }

    mutating func getItem(forCard card: Card) -> String {
        if emoji[card] == nil, emojiArray.count > 0 {
            let randomEmoji = emojiArray.remove(at: emojiArray.count.arc4random)
            emoji[card] = randomEmoji
        }
        return emoji[card] ?? "@"
    }

    mutating func getItemFromString(forCard card: Card) -> String {
        if emoji[card] == nil, emojiString.count > 0 {
            let randomStringIndex = emojiString.index(emojiString.startIndex,
                                                      offsetBy: emojiString.count.arc4random)
            emoji[card] = String(emojiString.remove(at: randomStringIndex))
        }
        return emoji[card] ?? "@"
    }

}
