//
//  ClaudeApplication.swift
//  Clippy
//
//  Created by Salomé Russier on 13/11/2026.
//

import AppKit

@MainActor
struct ClaudeApplication {
    private let linkFinder: ClaudeSessionLinkFinder

    init(linkFinder: ClaudeSessionLinkFinder = .init()) {
        self.linkFinder = linkFinder
    }

    func activate() {
        guard let url = NSWorkspace.shared.urlForApplication(withBundleIdentifier: Constants.claudeBundleIdentifier) else { return }
        NSWorkspace.shared.openApplication(at: url, configuration: .init())
    }

    func open(sessionID: String) async {
        if let link = await linkFinder.link(for: sessionID), NSWorkspace.shared.open(link) {
            return
        }
        activate()
    }
}

private extension Constants {
    static let claudeBundleIdentifier: String = "com.anthropic.claudefordesktop"
}
