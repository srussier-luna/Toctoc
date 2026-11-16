//
//  MoodMotionModifier.swift
//  Clippy
//
//  Created by Salomé Russier on 13/11/2026.
//

import SwiftUI

struct MoodMotionModifier: ViewModifier {
    let mood: Mood

    @ViewBuilder
    func body(content: Content) -> some View {
        switch mood {
        case .working:
            content.phaseAnimator(Constants.swayDirections) { view, direction in
                view.rotationEffect(.degrees(direction * Constants.swayAngle), anchor: .bottom)
            } animation: { _ in
                .easeInOut(duration: Constants.swayDuration)
            }
        case .waiting:
            content.phaseAnimator(Constants.pulseScales) { view, scale in
                view.scaleEffect(scale, anchor: .bottom)
            } animation: { _ in
                .easeInOut(duration: Constants.pulseDuration)
            }
        case .idle, .finished, .failed:
            content
        }
    }
}

private extension Constants {
    static let swayDirections: [Double] = [-1, 1]
    static let swayAngle: Double = 4
    static let swayDuration: Double = 0.9
    static let pulseScales: [CGFloat] = [1, 1.06]
    static let pulseDuration: Double = 0.7
}
