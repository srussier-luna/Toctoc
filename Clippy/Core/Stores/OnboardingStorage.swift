//
//  OnboardingStorage.swift
//  Clippy
//
//  Created by Salomé Russier on 16/11/2026.
//

import Foundation

struct OnboardingStorage {
    private let defaults: UserDefaults

    init(defaults: UserDefaults = .standard) {
        self.defaults = defaults
    }

    func isDone() -> Bool {
        defaults.bool(forKey: Constants.doneKey)
    }

    func saveDone() {
        defaults.set(true, forKey: Constants.doneKey)
    }
}

private extension Constants {
    static let doneKey: String = "onboardingDone"
}
