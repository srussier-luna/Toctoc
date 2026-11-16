//
//  BubbleStackView.swift
//  Clippy
//
//  Created by Salomé Russier on 16/11/2026.
//

import SwiftUI

struct BubbleStackView: View {
    let store: SessionStore
    let onboarding: OnboardingStore
    let claude: ClaudeApplication

    private var side: BubbleSide = .left
    private var onBubbleFramesChange: @MainActor ([CGRect]) -> Void = { _ in }

    @State private var frames: [UUID: CGRect] = [:]

    @Environment(\.openURL) private var openURL: OpenURLAction

    init(store: SessionStore, onboarding: OnboardingStore, claude: ClaudeApplication) {
        self.store = store
        self.onboarding = onboarding
        self.claude = claude
    }

    var body: some View {
        VStack(alignment: alignment.horizontal, spacing: Constants.spacing) {
            if onboarding.isShown {
                ForEach(onboarding.steps) { step in
                    bubbleButton(id: step.id) {
                        dismiss(from: step)
                    } label: {
                        BubbleView(step.message)
                            .multiline()
                    }
                }
            } else {
                ForEach(store.bubbles) { bubble in
                    bubbleButton(id: bubble.id) {
                        open(bubble)
                    } label: {
                        BubbleView(bubble.message)
                    }
                }
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: alignment)
        .padding(Constants.shadowInset)
        .animation(.spring(duration: Constants.animationDuration), value: shownIDs)
        .onChange(of: shownIDs) {
            frames = frames.filter { id, _ in shownIDs.contains(id) }
        }
        .onChange(of: bubbleFrames, initial: true) {
            onBubbleFramesChange(bubbleFrames)
        }
    }

    private var alignment: Alignment {
        switch side {
        case .left:
            .bottomTrailing
        case .right:
            .bottomLeading
        }
    }

    private var anchor: UnitPoint {
        switch side {
        case .left:
            .bottomTrailing
        case .right:
            .bottomLeading
        }
    }

    private var shownIDs: [UUID] {
        onboarding.isShown ? onboarding.steps.map(\.id) : store.bubbles.map(\.id)
    }

    private var bubbleFrames: [CGRect] {
        shownIDs.compactMap { frames[$0] }
    }

    private func bubbleButton(
        id: UUID,
        action: @escaping @MainActor () -> Void,
        @ViewBuilder label: () -> some View
    ) -> some View {
        Button(action: action, label: label)
            .buttonStyle(.plain)
            .accessibilityIdentifier(Constants.identifier)
            .onGeometryChange(for: CGRect.self) { proxy in
                proxy.frame(in: .global)
            } action: { frame in
                frames[id] = frame
            }
            .transition(.scale(scale: Constants.appearScale, anchor: anchor).combined(with: .opacity))
    }

    private func dismiss(from step: OnboardingStep) {
        if let link = step.link {
            openURL(link)
        }
        onboarding.dismiss(step)
    }

    private func open(_ bubble: Bubble) {
        store.dismiss(sessionID: bubble.sessionID)
        Task {
            await claude.open(sessionID: bubble.sessionID)
        }
    }
}

extension BubbleStackView {
    func side(_ side: BubbleSide) -> Self {
        var copy: Self = self
        copy.side = side
        return copy
    }

    func onBubbleFramesChange(perform action: @escaping @MainActor ([CGRect]) -> Void) -> Self {
        var copy: Self = self
        copy.onBubbleFramesChange = action
        return copy
    }
}

private extension Constants {
    static let identifier: String = "clippy.bubble"
    static let spacing: CGFloat = 8
    static let shadowInset: CGFloat = 8
    static let appearScale: CGFloat = 0.6
    static let animationDuration: Double = 0.3
}
