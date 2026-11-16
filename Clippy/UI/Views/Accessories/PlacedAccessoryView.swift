//
//  PlacedAccessoryView.swift
//  Clippy
//
//  Created by Salomé Russier on 16/11/2026.
//

import SwiftUI

struct PlacedAccessoryView: View {
    let accessory: AccessoryKind?
    let character: CharacterKind

    init(_ accessory: AccessoryKind?, on character: CharacterKind) {
        self.accessory = accessory
        self.character = character
    }

    var body: some View {
        if let accessory, let placement = AccessoryPlacement(character: character, accessory: accessory) {
            AccessoryView(accessory)
                .scaleEffect(placement.scale)
                .rotationEffect(.degrees(placement.angle))
                .offset(placement.offset)
        }
    }
}
