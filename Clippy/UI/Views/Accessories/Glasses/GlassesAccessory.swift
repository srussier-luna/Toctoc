//
//  GlassesAccessory.swift
//  Clippy
//
//  Created by Salomé Russier on 16/11/2026.
//

import SwiftUI

struct GlassesAccessory: View {
    var body: some View {
        ZStack {
            ForEach(Constants.mirrors, id: \.self) { mirror in
                Capsule()
                    .fill(Constants.frameColor)
                    .frame(width: Constants.templeSize.width, height: Constants.templeSize.height)
                    .offset(x: mirror * Constants.templeX, y: Constants.templeY)
                Circle()
                    .fill(Constants.glassColor)
                    .overlay {
                        Circle()
                            .strokeBorder(Constants.frameColor, lineWidth: Constants.frameWidth)
                    }
                    .frame(width: Constants.lensSize, height: Constants.lensSize)
                    .offset(x: mirror * Constants.lensX)
            }
            Capsule()
                .fill(Constants.frameColor)
                .frame(width: Constants.bridgeSize.width, height: Constants.bridgeSize.height)
                .offset(y: Constants.bridgeY)
        }
    }
}

private extension Constants {
    static let mirrors: [CGFloat] = [-1, 1]
    static let frameColor: Color = .init(white: 0.1)
    static let glassColor: Color = .white.opacity(0.18)
    static let frameWidth: CGFloat = 2
    static let lensSize: CGFloat = 19
    static let lensX: CGFloat = 10
    static let bridgeSize: CGSize = .init(width: 5, height: 2)
    static let bridgeY: CGFloat = -2
    static let templeSize: CGSize = .init(width: 6, height: 2)
    static let templeX: CGFloat = 21
    static let templeY: CGFloat = -3
}
