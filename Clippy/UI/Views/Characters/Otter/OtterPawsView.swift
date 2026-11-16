//
//  OtterPawsView.swift
//  Clippy
//
//  Created by Salomé Russier on 16/11/2026.
//

import SwiftUI

struct OtterPawsView: View {
    let isPaddling: Bool

    var body: some View {
        if isPaddling {
            PhaseAnimator(Constants.strokes) { stroke in
                paws(lift: stroke * Constants.strokeLift)
            } animation: { _ in
                .easeInOut(duration: Constants.strokeDuration)
            }
        } else {
            paws(lift: .zero)
        }
    }

    private func paws(lift: CGFloat) -> some View {
        HStack(spacing: Constants.spacing) {
            Capsule()
                .fill(Constants.color)
                .frame(width: Constants.size.width, height: Constants.size.height)
                .offset(y: lift)
            Capsule()
                .fill(Constants.color)
                .frame(width: Constants.size.width, height: Constants.size.height)
                .offset(y: -lift)
        }
    }
}

private extension Constants {
    static let color: Color = .init(red: 0.4, green: 0.25, blue: 0.15)
    static let size: CGSize = .init(width: 9, height: 12)
    static let spacing: CGFloat = 12
    static let strokes: [CGFloat] = [-1, 1]
    static let strokeLift: CGFloat = 3
    static let strokeDuration: Double = 0.45
}
