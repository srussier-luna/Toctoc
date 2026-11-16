//
//  OnboardingStep.swift
//  Clippy
//
//  Created by Salomé Russier on 16/11/2026.
//

import Foundation

struct OnboardingStep: Identifiable, Equatable {
    let id: UUID = .init()
    let message: String
    let link: URL?

    init(_ message: String, link: URL? = nil) {
        self.message = message
        self.link = link
    }
}
