//
//  NSPanelExtension.swift
//  Clippy
//
//  Created by Salomé Russier on 13/11/2026.
//

import AppKit

extension NSPanel {
    static func overlay(content: NSView, size: CGSize, isClickThrough: Bool) -> NSPanel {
        let panel: NSPanel = .init(
            contentRect: .init(origin: .zero, size: size),
            styleMask: [.borderless, .nonactivatingPanel],
            backing: .buffered,
            defer: false
        )
        panel.hidesOnDeactivate = false
        panel.level = .statusBar
        panel.collectionBehavior = [
            .canJoinAllSpaces,
            .canJoinAllApplications,
            .stationary,
            .ignoresCycle,
            .fullScreenAuxiliary
        ]
        panel.ignoresMouseEvents = isClickThrough
        panel.isOpaque = false
        panel.backgroundColor = .clear
        panel.hasShadow = false
        panel.isReleasedWhenClosed = false
        panel.animationBehavior = .none
        panel.contentView = content
        return panel
    }
}
