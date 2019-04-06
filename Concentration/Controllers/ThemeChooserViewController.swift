//
//  ThemeChooserViewController.swift
//  Concentration
//
//  Created by Ales Shenshin on 05/04/2019.
//  Copyright © 2019 Ales Shenshin. All rights reserved.
//

import UIKit

class ThemeChooserViewController: UIViewController {

    var theme: String = ""
    let themes: [String: String] = [
        "Sports": "⚽️🏀🏈🎾🎱🥊🥋⛸🏹🎿🏂⛳️🏊🏻‍♂️",
         "Animals": "🐶🐱🐭🐹🐰🦊🐻🐼🐨🐯🦁🐮🐷",
         "Faces": "👩🏻‍🌾🧕🏾👮🏼‍♂️👷🏻‍♂️👨🏼‍⚕️👨🏻‍🍳👨🏼‍💻👨🏼‍🏫🕵🏻‍♂️👩🏻‍🔬👩🏻‍🎨👨🏻‍🚒👨🏼‍✈️"
    ]

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "Choose Theme" {
            guard let cvc = segue.destination as? ConcentrationViewController else {return}
            cvc.theme = self.theme
        }
    }

    @IBAction func chooseTheme(_ sender: Any) {
        guard let button = sender as? UIButton else {return}
        guard let themeName = button.currentTitle else {return}
        guard let theme = themes[themeName] else {return}
        self.theme = theme
        performSegue(withIdentifier: "Choose Theme", sender: self)
    }

}
