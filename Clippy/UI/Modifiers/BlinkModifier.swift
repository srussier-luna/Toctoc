//
//  BlinkModifier.swift
//  Clippy
//
//  Created by Salomé Russier on 13/11/2026.
//

import SwiftUI

struct BlinkModifier: ViewModifier {
    func body(content: Content) -> some View {
        content.phaseAnimator(Constants.blinkOpenness) { view, openness in
            view.scaleEffect(x: 1, y: openness)
        } animation: { openness in
            openness < 1 ? .easeIn(duration: Constants.closeDuration).delay(Constants.openDelay) : .easeOut(duration: Constants.openDuration)
        }
    }
}

private extension Constants {
    static let blinkOpenness: [CGFloat] = [1, 0.1]
    static let openDelay: Double = 3.6
    static let closeDuration: Double = 0.07
    static let openDuration: Double = 0.09
}
