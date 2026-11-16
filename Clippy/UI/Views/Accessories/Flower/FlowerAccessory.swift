//
//  FlowerAccessory.swift
//  Clippy
//
//  Created by Salomé Russier on 16/11/2026.
//

import SwiftUI

struct FlowerAccessory: View {
    var body: some View {
        ZStack {
            ForEach(Constants.petalAngles, id: \.self) { angle in
                Ellipse()
                    .fill(Constants.petalColor)
                    .frame(width: Constants.petalSize.width, height: Constants.petalSize.height)
                    .offset(y: Constants.petalY)
                    .rotationEffect(.degrees(angle))
            }
            Circle()
                .fill(Constants.heartColor)
                .frame(width: Constants.heartSize, height: Constants.heartSize)
        }
    }
}

private extension Constants {
    static let petalColor: Color = .init(red: 1, green: 0.52, blue: 0.68)
    static let heartColor: Color = .init(red: 1, green: 0.84, blue: 0.25)
    static let petalAngles: [Double] = [0, 72, 144, 216, 288]
    static let petalSize: CGSize = .init(width: 6, height: 8)
    static let petalY: CGFloat = -4
    static let heartSize: CGFloat = 5
}
