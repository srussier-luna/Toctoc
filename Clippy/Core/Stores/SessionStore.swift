//
//  SessionStore.swift
//  Clippy
//
//  Created by Salomé Russier on 13/11/2026.
//

import Foundation
import Observation
import OSLog

@MainActor
@Observable
final class SessionStore {
    private(set) var mood: Mood = .idle
    private(set) var bubbles: [Bubble] = []
    @ObservationIgnored var areBubblesShown: Bool = true {
        didSet {
            guard areBubblesShown, !oldValue else { return }
            pendingExpiries.forEach { remove($0, after: bubbleDuration) }
            pendingExpiries = []
        }
    }

    @ObservationIgnored private var sessions: [String: Session] = [:]
    @ObservationIgnored private var pendingExpiries: [Bubble] = []
    @ObservationIgnored private let bubbleDuration: Duration

    init(bubbleDuration: Duration) {
        self.bubbleDuration = bubbleDuration
    }

    func handle(_ event: ClippyEvent) {
        if let session = sessions[event.sessionID], event.date < session.lastEventDate {
            Constants.logger.info("Ignored stale \(event.kind.rawValue, privacy: .public) for \(event.sessionID, privacy: .public)")
            return
        }
        switch event.kind {
        case .promptSubmitted:
            record(event, as: .working)
            bubbles.removeAll { $0.sessionID == event.sessionID }
        case .toolFinished:
            record(event, as: .working)
            bubbles.removeAll { $0.sessionID == event.sessionID && $0.mood != .finished }
        case .questionAsked, .permissionRequested:
            notify(event, as: .waiting)
        case .finished:
            notify(event, as: .finished)
        case .failed:
            notify(event, as: .failed)
        case .sessionEnded:
            record(event, as: .idle)
            bubbles.removeAll { $0.sessionID == event.sessionID }
        }
        refreshMood()
    }

    func acknowledge() {
        sessions = sessions.mapValues { session in
            Constants.acknowledgedMoods.contains(session.mood) ? .init(mood: .idle, lastEventDate: session.lastEventDate) : session
        }
        bubbles = []
        refreshMood()
    }

    func dismiss(sessionID: String) {
        bubbles.removeAll { $0.sessionID == sessionID }
    }

    private func record(_ event: ClippyEvent, as mood: Mood) {
        sessions[event.sessionID] = .init(mood: mood, lastEventDate: event.date)
    }

    private func notify(_ event: ClippyEvent, as mood: Mood) {
        record(event, as: mood)
        let bubble: Bubble = .init(sessionID: event.sessionID, title: event.title, mood: mood)
        show(bubble)
        guard Constants.expiringMoods.contains(mood) else { return }
        guard areBubblesShown else {
            pendingExpiries.append(bubble)
            return
        }
        remove(bubble, after: bubbleDuration)
    }

    private func refreshMood() {
        mood = Constants.priority.first { candidate in
            sessions.values.contains { $0.mood == candidate }
        } ?? .idle
    }

    private func show(_ bubble: Bubble) {
        let others: [Bubble] = bubbles.filter { $0.sessionID != bubble.sessionID }
        bubbles = Array((others + [bubble]).suffix(Constants.bubbleLimit))
    }

    private func remove(_ bubble: Bubble, after duration: Duration) {
        Task { [weak self] in
            try? await Task.sleep(for: duration)
            self?.bubbles.removeAll { $0.id == bubble.id }
        }
    }
}

private extension Constants {
    static let logger: Logger = .init(subsystem: "com.srussier.Clippy", category: "sessions")
    static let priority: [Mood] = [.waiting, .failed, .working, .finished]
    static let bubbleLimit: Int = 3
    static let acknowledgedMoods: Set<Mood> = [.finished, .failed]
    static let expiringMoods: Set<Mood> = [.failed]
}
