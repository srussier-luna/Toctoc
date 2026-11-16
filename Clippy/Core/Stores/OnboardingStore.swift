//
//  OnboardingStore.swift
//  Clippy
//
//  Created by Salomé Russier on 16/11/2026.
//

import Foundation
import Observation

@MainActor
@Observable
final class OnboardingStore {
    private(set) var steps: [OnboardingStep]

    @ObservationIgnored private let storage: OnboardingStorage

    var isShown: Bool {
        !steps.isEmpty
    }

    init(storage: OnboardingStorage = .init()) {
        self.storage = storage
        steps = storage.isDone() ? [] : Constants.steps
    }

    func dismiss(_ step: OnboardingStep) {
        steps.removeAll { $0.id == step.id }
        guard !isShown else { return }
        storage.saveDone()
    }
}

private extension Constants {
    static let guideURL: URL? = .init(string: "https://github.com/srussier-luna/Toctoc#readme")
    static let steps: [OnboardingStep] = [
        .init("Coucou\u{202F}! Moi c'est Toctoc."),
        .init("Je te préviens quand un agent Claude a fini ou t'attend."),
        .init("Glisse-moi où tu veux. Clique une bulle pour ouvrir sa conversation."),
        .init("Mon menu est en haut, derrière la porte\u{202F}: change de tête ou d'accessoire."),
        .init("Branche-moi à Claude\u{202F}: clique ici pour le guide.", link: guideURL)
    ]
}
