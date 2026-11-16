//
//  CharacterView.swift
//  Clippy
//
//  Created by Salomé Russier on 16/11/2026.
//

import SwiftUI

struct CharacterView: View {
    let kind: CharacterKind
    let mood: Mood

    private var accessory: AccessoryKind?

    init(_ kind: CharacterKind, mood: Mood) {
        self.kind = kind
        self.mood = mood
    }

    var body: some View {
        Group {
            switch kind {
            case .paperclip:
                PaperclipCharacter(mood: mood)
                    .overlay { placedAccessory }
            case .otter:
                OtterCharacter(mood: mood) { placedAccessory }
            case .owl:
                OwlCharacter(mood: mood)
                    .overlay { placedAccessory }
            case .cup:
                CupCharacter(mood: mood) { placedAccessory }
            case .cloud:
                CloudCharacter(mood: mood)
                    .overlay { placedAccessory }
            case .plant:
                PlantCharacter(mood: mood) { placedAccessory }
            case .tiger:
                TigerCharacter(mood: mood)
                    .overlay { placedAccessory }
            }
        }
        .shadow(color: .black.opacity(Constants.shadowOpacity), radius: Constants.shadowRadius, y: Constants.shadowOffset)
        .modifier(MoodMotionModifier(mood: mood))
        .phaseAnimator(Constants.hop, trigger: mood) { view, offset in
            view.offset(y: mood == .finished ? offset : .zero)
        } animation: { _ in
            .spring(duration: Constants.hopDuration, bounce: Constants.hopBounce)
        }
    }

    private var placedAccessory: PlacedAccessoryView {
        .init(accessory, on: kind)
    }
}

extension CharacterView {
    func accessory(_ accessory: AccessoryKind?) -> Self {
        var copy: Self = self
        copy.accessory = accessory
        return copy
    }
}

private extension Constants {
    static let shadowOpacity: Double = 0.35
    static let shadowRadius: CGFloat = 2
    static let shadowOffset: CGFloat = 1
    static let hop: [CGFloat] = [0, -14, 0]
    static let hopDuration: Double = 0.22
    static let hopBounce: Double = 0.5
}
