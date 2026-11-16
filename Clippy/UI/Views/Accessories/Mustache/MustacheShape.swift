//
//  MustacheShape.swift
//  Clippy
//
//  Created by Salomé Russier on 16/11/2026.
//

import SwiftUI

struct MustacheShape: Shape {
    func path(in rect: CGRect) -> Path {
        var path: Path = .init()
        for mirror in Constants.mirrors {
            let point: (CGPoint) -> CGPoint = { unit in
                .init(x: rect.midX + mirror * unit.x * rect.width / 2, y: rect.minY + unit.y * rect.height)
            }
            path.move(to: point(Constants.top))
            path.addCurve(
                to: point(Constants.tip),
                control1: point(Constants.upperControl1),
                control2: point(Constants.upperControl2)
            )
            path.addCurve(
                to: point(Constants.bottom),
                control1: point(Constants.lowerControl1),
                control2: point(Constants.lowerControl2)
            )
            path.closeSubpath()
        }
        return path
    }
}

private extension Constants {
    static let mirrors: [CGFloat] = [-1, 1]
    static let top: CGPoint = .init(x: 0, y: 0.15)
    static let upperControl1: CGPoint = .init(x: 0.35, y: -0.05)
    static let upperControl2: CGPoint = .init(x: 0.65, y: 0.6)
    static let tip: CGPoint = .init(x: 0.96, y: 0.02)
    static let lowerControl1: CGPoint = .init(x: 0.98, y: 0.7)
    static let lowerControl2: CGPoint = .init(x: 0.4, y: 1.05)
    static let bottom: CGPoint = .init(x: 0, y: 0.7)
}
