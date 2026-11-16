//
//  CharacterName.swift
//  Clippy
//
//  Created by Salomé Russier on 16/11/2026.
//

struct CharacterName {
    let text: String

    init(_ kind: CharacterKind) {
        switch kind {
        case .paperclip: text = "Trombone"
        case .otter: text = "Pépin"
        case .owl: text = "Plume"
        case .cup: text = "Noisette"
        case .cloud: text = "Coton"
        case .plant: text = "Brindille"
        case .tiger: text = "Rayure"
        }
    }
}
