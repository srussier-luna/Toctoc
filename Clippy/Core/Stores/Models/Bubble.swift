//
//  Bubble.swift
//  Clippy
//
//  Created by Salomé Russier on 13/11/2026.
//

import Foundation

struct Bubble: Identifiable, Equatable {
    let id: UUID = .init()
    let sessionID: String
    let title: String
    let mood: Mood

    var message: String {
        switch mood {
        case .finished: "Fini · \(title)"
        case .waiting: "Coucou\u{202F}! On t'attend · \(title)"
        case .failed: "Oups · \(title)"
        case .idle, .working: title
        }
    }
}
