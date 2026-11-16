//
//  ClippyPositionStorage.swift
//  Clippy
//
//  Created by Salomé Russier on 16/11/2026.
//

import Foundation

struct ClippyPositionStorage {
    private let defaults: UserDefaults

    init(defaults: UserDefaults = .standard) {
        self.defaults = defaults
    }

    func load() -> ClippyPosition? {
        guard let data = defaults.data(forKey: Constants.positionKey) else { return nil }
        return try? JSONDecoder().decode(ClippyPosition.self, from: data)
    }

    func save(_ position: ClippyPosition) {
        guard let data = try? JSONEncoder().encode(position) else { return }
        defaults.set(data, forKey: Constants.positionKey)
    }
}

private extension Constants {
    static let positionKey: String = "clippyPosition"
}
