//
//  CharacterStorage.swift
//  Clippy
//
//  Created by Salomé Russier on 16/11/2026.
//

import Foundation

struct CharacterStorage {
    private let defaults: UserDefaults

    init(defaults: UserDefaults = .standard) {
        self.defaults = defaults
    }

    func load() -> CharacterKind? {
        defaults.string(forKey: Constants.characterKey).flatMap(CharacterKind.init(rawValue:))
    }

    func loadAccessory() -> AccessoryKind? {
        defaults.string(forKey: Constants.accessoryKey).flatMap(AccessoryKind.init(rawValue:))
    }

    func save(_ kind: CharacterKind) {
        defaults.set(kind.rawValue, forKey: Constants.characterKey)
    }

    func save(_ accessory: AccessoryKind?) {
        defaults.set(accessory?.rawValue, forKey: Constants.accessoryKey)
    }
}

private extension Constants {
    static let characterKey: String = "character"
    static let accessoryKey: String = "accessory"
}
