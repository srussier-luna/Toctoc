//
//  OverlayPlacement.swift
//  Clippy
//
//  Created by Salomé Russier on 16/11/2026.
//

import CoreGraphics

struct OverlayPlacement: Equatable, Sendable {
    let screen: OverlayScreen
    let characterOrigin: CGPoint
    let bubbleOrigin: CGPoint
    let bubbleSide: BubbleSide
}
