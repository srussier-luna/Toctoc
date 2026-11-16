//
//  CharacterMenuView.swift
//  Clippy
//
//  Created by Salomé Russier on 16/11/2026.
//

import SwiftUI

struct CharacterMenuView: View {
    @Bindable private var store: CharacterStore

    init(store: CharacterStore) {
        self.store = store
    }

    var body: some View {
        Picker("Personnage", selection: $store.kind) {
            ForEach(CharacterKind.allCases, id: \.self) { kind in
                Text(CharacterName(kind).text)
                    .tag(kind)
            }
        }
        .pickerStyle(.inline)
        .accessibilityIdentifier(Constants.pickerIdentifier)
        Divider()
        AccessoryMenu(store: store)
        QuitButton()
    }
}

private extension Constants {
    static let pickerIdentifier: String = "clippy.characterPicker"
}
