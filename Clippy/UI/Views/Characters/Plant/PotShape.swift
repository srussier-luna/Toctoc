//
//  PotShape.swift
//  Clippy
//
//  Created by Salomé Russier on 16/11/2026.
//

import SwiftUI

struct PotShape: Shape {
    func path(in rect: CGRect) -> Path {
        let inset: CGFloat = rect.width * Constants.taper
        var path: Path = .init()
        path.move(to: .init(x: rect.minX, y: rect.minY))
        path.addLine(to: .init(x: rect.maxX, y: rect.minY))
        path.addLine(to: .init(x: rect.maxX - inset, y: rect.maxY))
        path.addLine(to: .init(x: rect.minX + inset, y: rect.maxY))
        path.closeSubpath()
        return path
    }
}

private extension Constants {
    static let taper: CGFloat = 0.15
}
