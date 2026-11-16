//
//  AccessoryName.swift
//  Clippy
//
//  Created by Salomé Russier on 16/11/2026.
//

struct AccessoryName {
    let text: String

    init(_ kind: AccessoryKind) {
        switch kind {
        case .cap: text = "Casquette"
        case .glasses: text = "Lunettes"
        case .bowTie: text = "Nœud papillon"
        case .headphones: text = "Casque audio"
        case .beanie: text = "Bonnet"
        case .scarf: text = "Écharpe"
        case .mustache: text = "Moustache"
        case .flower: text = "Fleur"
        case .spoon: text = "Cuillère"
        }
    }
}
