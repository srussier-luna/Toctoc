//
//  QuitButton.swift
//  Clippy
//
//  Created by Salomé Russier on 16/11/2026.
//

import SwiftUI

struct QuitButton: View {
    var body: some View {
        Button("Quitter Toctoc") {
            NSApplication.shared.terminate(nil)
        }
        .accessibilityIdentifier(Constants.identifier)
    }
}

private extension Constants {
    static let identifier: String = "clippy.quit"
}
