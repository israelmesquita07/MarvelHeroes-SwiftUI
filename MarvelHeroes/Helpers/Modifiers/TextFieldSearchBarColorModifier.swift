//
//  TextFieldSearchBarColorModifier.swift
//  MarvelHeroes
//
//  Created by Israel Pinheiro Braga Mesquita on 26/06/24.
//

import SwiftUI

struct TextFieldSearchBarColor: ViewModifier {
    init(backgroundColor: UIColor, tintColor: UIColor) {
        UITextField.appearance(whenContainedInInstancesOf: [UISearchBar.self]).backgroundColor = backgroundColor
        UITextField.appearance(whenContainedInInstancesOf: [UISearchBar.self]).tintColor = tintColor
    }

    func body(content: Content) -> some View {
        content
    }
}
