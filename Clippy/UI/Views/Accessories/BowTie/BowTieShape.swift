//
//  BowTieShape.swift
//  Clippy
//
//  Created by Salomé Russier on 16/11/2026.
//

import SwiftUI

struct BowTieShape: Shape {
    func path(in rect: CGRect) -> Path {
        let center: CGPoint = .init(x: rect.midX, y: rect.midY)
        var path: Path = .init()
        path.move(to: center)
        path.addLine(to: .init(x: rect.minX, y: rect.minY))
        path.addQuadCurve(
            to: .init(x: rect.minX, y: rect.maxY),
            control: .init(x: rect.minX - rect.width * Constants.bulge, y: rect.midY)
        )
        path.closeSubpath()
        path.move(to: center)
        path.addLine(to: .init(x: rect.maxX, y: rect.minY))
        path.addQuadCurve(
            to: .init(x: rect.maxX, y: rect.maxY),
            control: .init(x: rect.maxX + rect.width * Constants.bulge, y: rect.midY)
        )
        path.closeSubpath()
        return path
    }
}

private extension Constants {
    static let bulge: CGFloat = 0.08
}
