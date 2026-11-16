//
//  AccessoryPlacement.swift
//  Clippy
//
//  Created by Salomé Russier on 16/11/2026.
//

import CoreGraphics

struct AccessoryPlacement: Equatable {
    let offset: CGSize
    let scale: CGFloat
    let angle: Double

    init(offset: CGSize, scale: CGFloat, angle: Double) {
        self.offset = offset
        self.scale = scale
        self.angle = angle
    }

    init(offsetX: CGFloat, offsetY: CGFloat, scale: CGFloat = 1, angle: Double = .zero) {
        self.init(offset: .init(width: offsetX, height: offsetY), scale: scale, angle: angle)
    }

    init?(character: CharacterKind, accessory: AccessoryKind) {
        guard let placement = AccessoryLayout(character).placement(for: accessory) else {
            return nil
        }
        self = placement
    }
}
