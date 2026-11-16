//
//  BubbleStackView.swift
//  Clippy
//
//  Created by Salomé Russier on 16/11/2026.
//

import SwiftUI

struct BubbleStackView: View {
    let store: SessionStore
    let claude: ClaudeApplication

    private var side: BubbleSide = .left
    private var onBubbleFramesChange: @MainActor ([CGRect]) -> Void = { _ in }

    @State private var frames: [Bubble.ID: CGRect] = [:]

    init(store: SessionStore, claude: ClaudeApplication) {
        self.store = store
        self.claude = claude
    }

    var body: some View {
        VStack(alignment: alignment.horizontal, spacing: Constants.spacing) {
            ForEach(store.bubbles) { bubble in
                Button {
                    open(bubble)
                } label: {
                    BubbleView(bubble.message)
                }
                .buttonStyle(.plain)
                .accessibilityIdentifier(Constants.identifier)
                .onGeometryChange(for: CGRect.self) { proxy in
                    proxy.frame(in: .global)
                } action: { frame in
                    frames[bubble.id] = frame
                }
                .transition(.scale(scale: Constants.appearScale, anchor: anchor).combined(with: .opacity))
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: alignment)
        .padding(Constants.shadowInset)
        .animation(.spring(duration: Constants.animationDuration), value: store.bubbles)
        .onChange(of: store.bubbles) {
            frames = frames.filter { id, _ in store.bubbles.contains { $0.id == id } }
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

    private var bubbleFrames: [CGRect] {
        store.bubbles.compactMap { frames[$0.id] }
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
