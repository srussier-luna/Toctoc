//
//  ClippyDrag.swift
//  Clippy
//
//  Created by Salomé Russier on 16/11/2026.
//

import CoreGraphics

struct ClippyDrag: Sendable {
    let mouseStart: CGPoint
    let originStart: CGPoint

    func origin(at mouseLocation: CGPoint) -> CGPoint {
        .init(
            x: originStart.x + mouseLocation.x - mouseStart.x,
            y: originStart.y + mouseLocation.y - mouseStart.y
        )
    }
}
