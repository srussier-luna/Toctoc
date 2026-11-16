//
//  ClippyEvent.swift
//  Clippy
//
//  Created by Salomé Russier on 13/11/2026.
//

import Foundation

struct ClippyEvent: Equatable {
    let kind: Kind
    let sessionID: String
    let title: String
    let date: Date
}

extension ClippyEvent {
    init?(url: URL) {
        guard url.scheme == Constants.scheme, url.host() == Constants.host else { return nil }
        let items: [URLQueryItem] = URLComponents(url: url, resolvingAgainstBaseURL: false)?.queryItems ?? []
        let values: [String: String] = items.reduce(into: [:]) { values, item in
            values[item.name] = item.value
        }
        guard let kind = Self.kind(hookName: values[Constants.nameKey], toolName: values[Constants.toolKey]) else { return nil }
        let project: String = values[Constants.projectKey] ?? ""
        let title: String = values[Constants.titleKey] ?? ""
        let timestamp: TimeInterval? = values[Constants.dateKey].flatMap(TimeInterval.init)
        self.init(
            kind: kind,
            sessionID: values[Constants.sessionKey] ?? "",
            title: title.isEmpty ? project : title,
            date: timestamp.map(Date.init(timeIntervalSince1970:)) ?? .now
        )
    }

    private static func kind(hookName: String?, toolName: String?) -> Kind? {
        switch hookName {
        case "UserPromptSubmit": .promptSubmitted
        case "PostToolUse": .toolFinished
        case "PreToolUse" where toolName == "AskUserQuestion": .questionAsked
        case "PermissionRequest": .permissionRequested
        case "Stop": .finished
        case "StopFailure": .failed
        case "SessionEnd": .sessionEnded
        default: nil
        }
    }
}

extension ClippyEvent {
    static func mock(
        kind: Kind = .finished,
        sessionID: String = "a",
        title: String = "Demo",
        date: Date = .now
    ) -> ClippyEvent {
        .init(kind: kind, sessionID: sessionID, title: title, date: date)
    }
}

private extension Constants {
    static let scheme: String = "clippy"
    static let host: String = "event"
    static let nameKey: String = "name"
    static let toolKey: String = "tool"
    static let sessionKey: String = "session"
    static let projectKey: String = "project"
    static let titleKey: String = "title"
    static let dateKey: String = "at"
}
