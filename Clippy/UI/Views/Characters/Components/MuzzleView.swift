//
//  MuzzleView.swift
//  Clippy
//
//  Created by Salomé Russier on 16/11/2026.
//

import SwiftUI

struct MuzzleView: View {
    let color: Color
    let noseColor: Color

    var body: some View {
        ZStack {
            ForEach(Constants.mirrors, id: \.self) { mirror in
                Circle()
                    .fill(color)
                    .frame(width: Constants.lobeSize, height: Constants.lobeSize)
                    .offset(x: mirror * Constants.lobeX)
                VStack(spacing: Constants.whiskerSpacing) {
                    ForEach(Constants.whiskerAngles, id: \.self) { angle in
                        Capsule()
                            .fill(Constants.whiskerColor)
                            .frame(width: Constants.whiskerSize.width, height: Constants.whiskerSize.height)
                            .rotationEffect(.degrees(angle * mirror))
                    }
                }
                .offset(x: mirror * Constants.whiskersX, y: Constants.whiskersY)
            }
            Ellipse()
                .fill(noseColor)
                .frame(width: Constants.noseSize.width, height: Constants.noseSize.height)
                .offset(y: Constants.noseY)
        }
    }
}

private extension Constants {
    static let mirrors: [CGFloat] = [-1, 1]
    static let lobeSize: CGFloat = 16
    static let lobeX: CGFloat = 6.5
    static let noseSize: CGSize = .init(width: 10, height: 7)
    static let noseY: CGFloat = -5
    static let whiskerColor: Color = .init(white: 0.97).opacity(0.9)
    static let whiskerAngles: [Double] = [-10, 2, 12]
    static let whiskerSize: CGSize = .init(width: 12, height: 1)
    static let whiskerSpacing: CGFloat = 2.5
    static let whiskersX: CGFloat = 18
    static let whiskersY: CGFloat = 2
}
