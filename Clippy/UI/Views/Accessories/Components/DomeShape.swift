//
//  DomeShape.swift
//  Clippy
//
//  Created by Salomé Russier on 16/11/2026.
//

import SwiftUI

struct DomeShape: Shape {
    func path(in rect: CGRect) -> Path {
        let handleX: CGFloat = rect.width / 2 * Constants.kappa
        let handleY: CGFloat = rect.height * Constants.kappa
        var path: Path = .init()
        path.move(to: .init(x: rect.minX, y: rect.maxY))
        path.addCurve(
            to: .init(x: rect.midX, y: rect.minY),
            control1: .init(x: rect.minX, y: rect.maxY - handleY),
            control2: .init(x: rect.midX - handleX, y: rect.minY)
        )
        path.addCurve(
            to: .init(x: rect.maxX, y: rect.maxY),
            control1: .init(x: rect.midX + handleX, y: rect.minY),
            control2: .init(x: rect.maxX, y: rect.maxY - handleY)
        )
        path.closeSubpath()
        return path
    }
}

private extension Constants {
    static let kappa: CGFloat = 0.5523
}
