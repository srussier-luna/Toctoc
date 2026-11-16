//
//  PathExtension.swift
//  Clippy
//
//  Created by Salomé Russier on 13/11/2026.
//

import SwiftUI

extension Path {
    mutating func addTurn(to end: CGPoint, bulge: TurnBulge) {
        guard let start = currentPoint else { return }
        let radius: CGFloat = abs(end.x - start.x) / 2
        let direction: CGFloat = end.x > start.x ? 1 : -1
        let depth: CGFloat = bulge == .downward ? radius : -radius
        let handle: CGFloat = radius * Constants.circleHandle
        let apex: CGPoint = .init(x: (start.x + end.x) / 2, y: start.y + depth)
        addCurve(
            to: apex,
            control1: .init(x: start.x, y: start.y + depth * Constants.circleHandle),
            control2: .init(x: apex.x - direction * handle, y: apex.y)
        )
        addCurve(
            to: end,
            control1: .init(x: apex.x + direction * handle, y: apex.y),
            control2: .init(x: end.x, y: end.y + depth * Constants.circleHandle)
        )
    }
}

private extension Constants {
    static let circleHandle: CGFloat = 0.5523
}
