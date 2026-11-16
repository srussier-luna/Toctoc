//
//  ShellShape.swift
//  Clippy
//
//  Created by Salomé Russier on 16/11/2026.
//

import SwiftUI

struct ShellShape: Shape {
    func path(in rect: CGRect) -> Path {
        let edgeY: CGFloat = rect.minY + rect.height * Constants.edge
        var path: Path = .init()
        path.move(to: .init(x: rect.midX, y: rect.maxY))
        path.addLine(to: .init(x: rect.minX, y: edgeY))
        path.addQuadCurve(
            to: .init(x: rect.maxX, y: edgeY),
            control: .init(x: rect.midX, y: rect.minY - rect.height * Constants.edge)
        )
        path.closeSubpath()
        return path
    }
}

private extension Constants {
    static let edge: CGFloat = 0.45
}
