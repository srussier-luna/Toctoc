//
//  LookAroundModifier.swift
//  Clippy
//
//  Created by Salomé Russier on 13/11/2026.
//

import SwiftUI

struct LookAroundModifier: ViewModifier {
    let isActive: Bool

    @ViewBuilder
    func body(content: Content) -> some View {
        if isActive {
            content.phaseAnimator(Constants.lookDirections) { view, direction in
                view.offset(x: direction * Constants.lookAmplitude)
            } animation: { _ in
                .easeInOut(duration: Constants.lookDuration)
            }
        } else {
            content
        }
    }
}

private extension Constants {
    static let lookDirections: [CGFloat] = [-1, 1]
    static let lookAmplitude: CGFloat = 3
    static let lookDuration: Double = 1.1
}
