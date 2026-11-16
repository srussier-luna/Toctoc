//
//  HappyEyeShape.swift
//  Clippy
//
//  Created by Salomé Russier on 13/11/2026.
//

import SwiftUI

struct HappyEyeShape: Shape {
    func path(in rect: CGRect) -> Path {
        var path: Path = .init()
        path.move(to: .init(x: rect.minX, y: rect.maxY))
        path.addQuadCurve(
            to: .init(x: rect.maxX, y: rect.maxY),
            control: .init(x: rect.midX, y: rect.minY - rect.height)
        )
        return path
    }
}
