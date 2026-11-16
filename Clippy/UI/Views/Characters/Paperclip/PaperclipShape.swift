//
//  PaperclipShape.swift
//  Clippy
//
//  Created by Salomé Russier on 13/11/2026.
//

import SwiftUI

struct PaperclipShape: Shape {
    func path(in rect: CGRect) -> Path {
        let outerLeft: CGFloat = rect.minX + rect.width * Constants.outerLeft
        let innerLeft: CGFloat = rect.minX + rect.width * Constants.innerLeft
        let innerRight: CGFloat = rect.minX + rect.width * Constants.innerRight
        let outerRight: CGFloat = rect.minX + rect.width * Constants.outerRight
        let top: CGFloat = rect.minY + rect.height * Constants.top
        let innerBottom: CGFloat = rect.minY + rect.height * Constants.innerBottom
        let outerBottom: CGFloat = rect.minY + rect.height * Constants.outerBottom
        var path: Path = .init()
        path.move(to: .init(x: innerRight, y: rect.minY + rect.height * Constants.start))
        path.addLine(to: .init(x: innerRight, y: innerBottom))
        path.addTurn(to: .init(x: innerLeft, y: innerBottom), bulge: .downward)
        path.addLine(to: .init(x: innerLeft, y: top))
        path.addTurn(to: .init(x: outerRight, y: top), bulge: .upward)
        path.addLine(to: .init(x: outerRight, y: outerBottom))
        path.addTurn(to: .init(x: outerLeft, y: outerBottom), bulge: .downward)
        path.addLine(to: .init(x: outerLeft, y: rect.minY + rect.height * Constants.end))
        return path
    }
}

private extension Constants {
    static let outerLeft: CGFloat = 0.1
    static let innerLeft: CGFloat = 0.32
    static let innerRight: CGFloat = 0.64
    static let outerRight: CGFloat = 0.9
    static let top: CGFloat = 0.17
    static let start: CGFloat = 0.3
    static let innerBottom: CGFloat = 0.7
    static let outerBottom: CGFloat = 0.8
    static let end: CGFloat = 0.4
}
