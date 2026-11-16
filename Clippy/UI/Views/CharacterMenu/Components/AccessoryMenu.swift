//
//  AccessoryMenu.swift
//  Clippy
//
//  Created by Salomé Russier on 16/11/2026.
//

import SwiftUI

struct AccessoryMenu: View {
    @Bindable private var store: CharacterStore

    init(store: CharacterStore) {
        self.store = store
    }

    var body: some View {
        Menu("Accessoire") {
            Picker("Accessoire", selection: $store.accessory) {
                Text("Aucun")
                    .tag(AccessoryKind?.none)
                ForEach(store.accessories, id: \.self) { accessory in
                    Text(AccessoryName(accessory).text)
                        .tag(AccessoryKind?.some(accessory))
                }
            }
            .pickerStyle(.inline)
            .labelsHidden()
            .accessibilityIdentifier(Constants.pickerIdentifier)
        }
        .accessibilityIdentifier(Constants.menuIdentifier)
    }
}

private extension Constants {
    static let menuIdentifier: String = "clippy.accessoryMenu"
    static let pickerIdentifier: String = "clippy.accessoryPicker"
}
