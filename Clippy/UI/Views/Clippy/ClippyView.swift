//
//  ClippyView.swift
//  Clippy
//
//  Created by Salomé Russier on 13/11/2026.
//

import SwiftUI

struct ClippyView: View {
    let store: SessionStore
    let character: CharacterStore
    let claude: ClaudeApplication

    private var onDragChange: @MainActor () -> Void = {}
    private var onDragEnd: @MainActor () -> Void = {}

    init(store: SessionStore, character: CharacterStore, claude: ClaudeApplication) {
        self.store = store
        self.character = character
        self.claude = claude
    }

    var body: some View {
        Button(action: openClaude) {
            CharacterView(character.kind, mood: store.mood)
                .accessory(character.accessory)
        }
        .buttonStyle(.plain)
        .highPriorityGesture(
            DragGesture(minimumDistance: Constants.dragThreshold)
                .onChanged { _ in onDragChange() }
                .onEnded { _ in onDragEnd() }
        )
        .contextMenu {
            Button("Ouvrir Claude", action: openClaude)
            QuitButton()
        }
        .accessibilityLabel(CharacterName(character.kind).text)
        .accessibilityIdentifier(Constants.identifier)
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .bottom)
    }

    private func openClaude() {
        store.acknowledge()
        claude.activate()
    }
}

extension ClippyView {
    func onDragChange(perform action: @escaping @MainActor () -> Void) -> Self {
        var copy: Self = self
        copy.onDragChange = action
        return copy
    }

    func onDragEnd(perform action: @escaping @MainActor () -> Void) -> Self {
        var copy: Self = self
        copy.onDragEnd = action
        return copy
    }
}

private extension Constants {
    static let identifier: String = "clippy.paperclip"
    static let dragThreshold: CGFloat = 3
}
