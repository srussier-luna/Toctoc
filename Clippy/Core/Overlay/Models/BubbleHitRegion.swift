//
//  BubbleHitRegion.swift
//  Clippy
//
//  Created by Salomé Russier on 16/11/2026.
//

import CoreGraphics

struct BubbleHitRegion {
    let panelFrame: CGRect
    let bubbleFrames: [CGRect]

    func contains(_ screenPoint: CGPoint) -> Bool {
        let point: CGPoint = .init(x: screenPoint.x - panelFrame.minX, y: panelFrame.maxY - screenPoint.y)
        return bubbleFrames.contains { $0.contains(point) }
    }
}
