//
//  ThemeChooserViewController.swift
//  Concentration
//
//  Created by Ales Shenshin on 05/04/2019.
//  Copyright © 2019 Ales Shenshin. All rights reserved.
//

import UIKit

class ThemeChooserViewController: UIViewController {

    //var theme: String = ""
    let themes: [String: String] = [
        "Sports": "⚽️🏀🏈🎾🎱🥊🥋⛸🏹🎿🏂⛳️🏊🏻‍♂️",
         "Animals": "🐶🐱🐭🐹🐰🦊🐻🐼🐨🐯🦁🐮🐷",
         "Faces": "👩🏻‍🌾🧕🏾👮🏼‍♂️👷🏻‍♂️👨🏼‍⚕️👨🏻‍🍳👨🏼‍💻👨🏼‍🏫🕵🏻‍♂️👩🏻‍🔬👩🏻‍🎨👨🏻‍🚒👨🏼‍✈️"
    ]

    private var lastSeguedToCVC: ConcentrationViewController?

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "Choose Theme", let cvc = segue.destination as? ConcentrationViewController {
            lastSeguedToCVC = cvc
            setTheme(sender: sender, cvc: cvc)
        }
    }

    /// Устанавливает в игровом вьюконтроллере тему по названию, взятому из заголовка кнопки
    /// - Parameter sender: Кнопка, из заголовка (currentTitle) которого берётся название темы
    /// - Parameter cvc: Игровой вью-контроллер, в котором нужно установить тему
    private func setTheme(sender: Any?, cvc: ConcentrationViewController) {
        if let themeName = (sender as? UIButton)?.currentTitle, let theme = themes[themeName] {
            cvc.theme = theme
        }
    }

    @IBAction func changeTheme(_ sender: Any) {
        //если ConcentrationViewController вызван, и находится
        //в соседнем окошке справа, то просто поменять в нём тему,
        if let cvc = splitViewController?.viewControllers.last as? ConcentrationViewController {
            setTheme(sender: sender, cvc: cvc)
        // если переход уже ранее был произведён, и существует сохранённый
        // в куче (heap) вьюконтроллер ConcentrationViewController, то
        // поместить его в navigation contoller
        } else if let cvc = lastSeguedToCVC {
            setTheme(sender: sender, cvc: cvc)
            navigationController?.pushViewController(cvc, animated: true)
        // а если не вызван, то вызвать его, передав управление методу
        // prepare, где будет установлена тема
        } else {
            performSegue(withIdentifier: "Choose Theme", sender: sender)
        }
    }
}
