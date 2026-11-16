//
//  OverlayLayout.swift
//  Clippy
//
//  Created by Salomé Russier on 16/11/2026.
//

import CoreGraphics

struct OverlayLayout: Sendable {
    let characterSize: CGSize
    let bubbleSize: CGSize
    let margin: CGFloat
    let bubbleLift: CGFloat

    func placement(for position: ClippyPosition?, among screens: [OverlayScreen]) -> OverlayPlacement? {
        guard let screen = screens.first(where: { $0.id == position?.screenID }) ?? screens.first else { return nil }
        let origin: CGPoint = position.map { origin(at: $0.relativePoint, in: screen.visibleFrame) } ?? defaultOrigin(in: screen.visibleFrame)
        return placement(of: origin, on: screen)
    }

    func placement(dragging origin: CGPoint, among screens: [OverlayScreen]) -> OverlayPlacement? {
        let center: CGPoint = .init(x: origin.x + characterSize.width / 2, y: origin.y + characterSize.height / 2)
        guard let screen = screens.min(by: { distance(from: center, to: $0.visibleFrame) < distance(from: center, to: $1.visibleFrame) }) else { return nil }
        return placement(of: origin, on: screen)
    }

    func position(of placement: OverlayPlacement) -> ClippyPosition {
        let visibleFrame: CGRect = placement.screen.visibleFrame
        let travel: CGSize = travel(in: visibleFrame)
        return .init(
            screenID: placement.screen.id,
            relativePoint: .init(
                x: fraction(placement.characterOrigin.x - visibleFrame.minX, of: travel.width),
                y: fraction(placement.characterOrigin.y - visibleFrame.minY, of: travel.height)
            )
        )
    }

    private func placement(of origin: CGPoint, on screen: OverlayScreen) -> OverlayPlacement {
        let visibleFrame: CGRect = screen.visibleFrame
        let characterOrigin: CGPoint = clamped(origin, size: characterSize, into: visibleFrame)
        let side: BubbleSide = characterOrigin.x - bubbleSize.width >= visibleFrame.minX ? .left : .right
        let bubbleOrigin: CGPoint = .init(
            x: side == .left ? characterOrigin.x - bubbleSize.width : characterOrigin.x + characterSize.width,
            y: characterOrigin.y + bubbleLift
        )
        return .init(
            screen: screen,
            characterOrigin: characterOrigin,
            bubbleOrigin: clamped(bubbleOrigin, size: bubbleSize, into: visibleFrame),
            bubbleSide: side
        )
    }

    private func defaultOrigin(in visibleFrame: CGRect) -> CGPoint {
        .init(
            x: visibleFrame.maxX - margin - characterSize.width,
            y: visibleFrame.minY + margin
        )
    }

    private func origin(at relativePoint: CGPoint, in visibleFrame: CGRect) -> CGPoint {
        let travel: CGSize = travel(in: visibleFrame)
        return .init(
            x: visibleFrame.minX + relativePoint.x * travel.width,
            y: visibleFrame.minY + relativePoint.y * travel.height
        )
    }

    private func travel(in visibleFrame: CGRect) -> CGSize {
        .init(
            width: max(visibleFrame.width - characterSize.width, .zero),
            height: max(visibleFrame.height - characterSize.height, .zero)
        )
    }

    private func fraction(_ offset: CGFloat, of length: CGFloat) -> CGFloat {
        length > .zero ? offset / length : .zero
    }

    private func clamped(_ origin: CGPoint, size: CGSize, into visibleFrame: CGRect) -> CGPoint {
        .init(
            x: min(max(origin.x, visibleFrame.minX), visibleFrame.maxX - size.width),
            y: min(max(origin.y, visibleFrame.minY), visibleFrame.maxY - size.height)
        )
    }

    private func distance(from point: CGPoint, to rect: CGRect) -> CGFloat {
        hypot(
            max(rect.minX - point.x, .zero, point.x - rect.maxX),
            max(rect.minY - point.y, .zero, point.y - rect.maxY)
        )
    }
}
