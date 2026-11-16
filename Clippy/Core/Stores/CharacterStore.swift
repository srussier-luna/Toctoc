//
//  CharacterStore.swift
//  Clippy
//
//  Created by Salomé Russier on 16/11/2026.
//

import Observation

@MainActor
@Observable
final class CharacterStore {
    var kind: CharacterKind {
        didSet {
            storage.save(kind)
            dropUnavailableAccessory()
        }
    }
    var accessory: AccessoryKind? {
        didSet {
            storage.save(accessory)
        }
    }

    @ObservationIgnored private let storage: CharacterStorage

    var accessories: [AccessoryKind] {
        AccessoryKind.allCases.filter(isAvailable)
    }

    init(storage: CharacterStorage = .init()) {
        self.storage = storage
        kind = storage.load() ?? Constants.defaultKind
        accessory = storage.loadAccessory()
        dropUnavailableAccessory()
    }

    private func isAvailable(_ accessory: AccessoryKind) -> Bool {
        accessory != .spoon || kind == .cup
    }

    private func dropUnavailableAccessory() {
        guard let accessory, !isAvailable(accessory) else {
            return
        }
        self.accessory = nil
    }
}

private extension Constants {
    static let defaultKind: CharacterKind = .paperclip
}
