//
//  ClippyPosition.swift
//  Clippy
//
//  Created by Salomé Russier on 16/11/2026.
//

import CoreGraphics

struct ClippyPosition: Codable, Equatable, Sendable {
    let screenID: CGDirectDisplayID
    let relativePoint: CGPoint
}
