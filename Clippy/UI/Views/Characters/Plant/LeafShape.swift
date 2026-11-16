//
//  LeafShape.swift
//  Clippy
//
//  Created by Salomé Russier on 16/11/2026.
//

import SwiftUI

struct LeafShape: Shape {
    func path(in rect: CGRect) -> Path {
        var path: Path = .init()
        path.move(to: .init(x: rect.minX, y: rect.midY))
        path.addQuadCurve(
            to: .init(x: rect.maxX, y: rect.midY),
            control: .init(x: rect.midX, y: rect.minY - rect.height * Constants.bulge)
        )
        path.addQuadCurve(
            to: .init(x: rect.minX, y: rect.midY),
            control: .init(x: rect.midX, y: rect.maxY + rect.height * Constants.bulge)
        )
        return path
    }
}

private extension Constants {
    static let bulge: CGFloat = 0.4
}
