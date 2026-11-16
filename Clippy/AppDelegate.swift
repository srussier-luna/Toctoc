//
//  AppDelegate.swift
//  Clippy
//
//  Created by Salomé Russier on 13/11/2026.
//

import AppKit
import OSLog

@MainActor
final class AppDelegate: NSObject, NSApplicationDelegate {
    let character: CharacterStore = .init()

    private let store: SessionStore = .init(bubbleDuration: Constants.bubbleDuration)
    private var overlay: ClippyOverlay?

    func applicationDidFinishLaunching(_ notification: Notification) {
        let overlay: ClippyOverlay = .init(store: store, character: character)
        overlay.show()
        self.overlay = overlay
    }

    func application(_ application: NSApplication, open urls: [URL]) {
        for url in urls {
            guard let event = ClippyEvent(url: url) else {
                Constants.logger.notice("Ignored URL \(url.absoluteString, privacy: .private)")
                continue
            }
            Constants.logger.info("Received \(event.kind.rawValue, privacy: .public) for \(event.sessionID, privacy: .public)")
            store.handle(event)
        }
    }
}

private extension Constants {
    static let logger: Logger = .init(subsystem: "com.srussier.Clippy", category: "events")
    static let bubbleDuration: Duration = .seconds(10)
}
