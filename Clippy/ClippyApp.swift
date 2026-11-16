//
//  ClippyApp.swift
//  Clippy
//
//  Created by Salomé Russier on 13/11/2026.
//

import SwiftUI

@main
struct ClippyApp: App {
    @NSApplicationDelegateAdaptor(AppDelegate.self) private var appDelegate: AppDelegate

    var body: some Scene {
        MenuBarExtra("Toctoc", systemImage: Constants.menuBarSymbol) {
            CharacterMenuView(store: appDelegate.character)
        }
    }
}

private extension Constants {
    static let menuBarSymbol: String = "door.left.hand.closed"
}
