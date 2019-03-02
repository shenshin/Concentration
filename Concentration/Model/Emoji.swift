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

    enum EmojiTheme {
        case halloween
        case sports
        case animals
        case people
        case flyingAnimals
        case letters
    }

    init(setTheme theme: EmojiTheme) {
        emojiArray = setTheme(theme)
        emojiArray.shuffle()
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
        //return "?"
        return identifier < emojiArray.count ? emojiArray[identifier] : "?"
    }

}
