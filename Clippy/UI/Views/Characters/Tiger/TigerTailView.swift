//
//  TigerTailView.swift
//  Clippy
//
//  Created by Salomé Russier on 16/11/2026.
//

import SwiftUI

struct TigerTailView: View {
    let isSwishing: Bool

    var body: some View {
        if isSwishing {
            PhaseAnimator(Constants.swishes) { swish in
                tail(angle: Constants.restAngle + swish * Constants.swishAngle)
            } animation: { _ in
                .easeInOut(duration: Constants.swishDuration)
            }
        } else {
            tail(angle: Constants.restAngle)
        }
    }

    private func tail(angle: Double) -> some View {
        Capsule()
            .fill(Constants.furColor)
            .overlay(alignment: .top) {
                Capsule()
                    .fill(Constants.stripeColor)
                    .frame(height: Constants.tipLength)
            }
            .frame(width: Constants.size.width, height: Constants.size.height)
            .rotationEffect(.degrees(angle), anchor: .bottom)
    }
}

private extension Constants {
    static let furColor: Color = .init(red: 0.93, green: 0.52, blue: 0.14)
    static let stripeColor: Color = .init(red: 0.22, green: 0.13, blue: 0.08)
    static let size: CGSize = .init(width: 6, height: 28)
    static let tipLength: CGFloat = 7
    static let restAngle: Double = 28
    static let swishes: [Double] = [-1, 1]
    static let swishAngle: Double = 10
    static let swishDuration: Double = 0.5
}
