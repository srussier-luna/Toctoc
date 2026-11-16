//
//  ClaudeSessionLinkFinder.swift
//  Clippy
//
//  Created by Salomé Russier on 16/11/2026.
//

import Foundation

struct ClaudeSessionLinkFinder: Sendable {
    private let root: URL

    init(root: URL) {
        self.root = root
    }

    init() {
        self.init(root: Constants.sessionsFolder)
    }

    @concurrent
    func link(for sessionID: String) async -> URL? {
        guard !sessionID.isEmpty else { return nil }
        let marker: Data = .init(sessionID.utf8)
        return sessionFiles()
            .first { isFile($0, of: sessionID, marker: marker) }
            .flatMap { URL(string: Constants.linkPrefix + $0.deletingPathExtension().lastPathComponent) }
    }

    private func sessionFiles() -> [URL] {
        items(in: root)
            .flatMap(items(in:))
            .flatMap(items(in:))
            .filter { $0.lastPathComponent.hasPrefix(Constants.filePrefix) && $0.pathExtension == Constants.fileExtension }
    }

    private func items(in folder: URL) -> [URL] {
        (try? FileManager.default.contentsOfDirectory(at: folder, includingPropertiesForKeys: nil)) ?? []
    }

    private func isFile(_ file: URL, of sessionID: String, marker: Data) -> Bool {
        guard
            let data = try? Data(contentsOf: file),
            data.range(of: marker) != nil,
            let sessionFile = try? JSONDecoder().decode(ClaudeSessionFile.self, from: data)
        else {
            return false
        }
        return sessionFile.cliSessionID == sessionID
    }
}

private extension Constants {
    static let sessionsFolder: URL = .applicationSupportDirectory.appending(path: "Claude/claude-code-sessions", directoryHint: .isDirectory)
    static let linkPrefix: String = "claude://claude.ai/epitaxy/"
    static let filePrefix: String = "local_"
    static let fileExtension: String = "json"
}
