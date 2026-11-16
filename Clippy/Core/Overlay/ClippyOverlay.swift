//
//  ClippyOverlay.swift
//  Clippy
//
//  Created by Salomé Russier on 13/11/2026.
//

import AppKit
import SwiftUI

@MainActor
final class ClippyOverlay {
    private let characterPanel: NSPanel
    private let bubblePanel: NSPanel
    private let bubbleView: FirstClickHostingView<BubbleStackView>
    private let layout: OverlayLayout = .init(
        characterSize: Constants.characterSize,
        bubbleSize: Constants.bubbleSize,
        margin: Constants.margin,
        bubbleLift: Constants.bubbleLift
    )
    private let storage: ClippyPositionStorage
    private var placement: OverlayPlacement?
    private var drag: ClippyDrag?
    private var bubbleFrames: [CGRect] = []
    private var screenObserver: (any NSObjectProtocol)?
    private var mouseMonitors: [Any] = []

    init(store: SessionStore, character: CharacterStore, storage: ClippyPositionStorage = .init()) {
        let characterView: FirstClickHostingView<ClippyView> = .init(rootView: .init(store: store, character: character, claude: .init()))
        characterView.sizingOptions = []
        bubbleView = .init(rootView: .init(store: store, claude: .init()))
        bubbleView.sizingOptions = []
        characterPanel = .overlay(content: characterView, size: Constants.characterSize, isClickThrough: false)
        bubblePanel = .overlay(content: bubbleView, size: Constants.bubbleSize, isClickThrough: true)
        self.storage = storage
        characterView.rootView = characterView.rootView
            .onDragChange { [weak self] in
                self?.follow(NSEvent.mouseLocation)
            }
            .onDragEnd { [weak self] in
                self?.drop()
            }
        bubbleView.rootView = bubbleView.rootView
            .onBubbleFramesChange { [weak self] frames in
                self?.bubbleFrames = frames
                self?.updateClickThrough()
            }
    }

    private var screens: [OverlayScreen] {
        NSScreen.screens.compactMap(\.overlayScreen)
    }

    func show() {
        restore()
        bubblePanel.orderFrontRegardless()
        characterPanel.orderFrontRegardless()
        screenObserver = NotificationCenter.default.addObserver(
            forName: NSApplication.didChangeScreenParametersNotification,
            object: nil,
            queue: .main
        ) { [weak self] _ in
            MainActor.assumeIsolated {
                self?.restore()
            }
        }
        mouseMonitors = [
            NSEvent.addGlobalMonitorForEvents(matching: Constants.trackedEvents) { [weak self] _ in
                MainActor.assumeIsolated {
                    self?.updateClickThrough()
                }
            },
            NSEvent.addLocalMonitorForEvents(matching: Constants.trackedEvents) { [weak self] event in
                MainActor.assumeIsolated {
                    self?.updateClickThrough()
                }
                return event
            }
        ].compactMap(\.self)
    }

    private func restore() {
        guard let placement = layout.placement(for: storage.load(), among: screens) else { return }
        apply(placement)
    }

    private func follow(_ mouseLocation: CGPoint) {
        let drag: ClippyDrag = drag ?? .init(mouseStart: mouseLocation, originStart: characterPanel.frame.origin)
        self.drag = drag
        guard let placement = layout.placement(dragging: drag.origin(at: mouseLocation), among: screens) else { return }
        apply(placement)
    }

    private func drop() {
        drag = nil
        guard let placement else { return }
        storage.save(layout.position(of: placement))
    }

    private func apply(_ placement: OverlayPlacement) {
        if placement.bubbleSide != self.placement?.bubbleSide {
            bubbleView.rootView = bubbleView.rootView.side(placement.bubbleSide)
        }
        characterPanel.setFrameOrigin(placement.characterOrigin)
        bubblePanel.setFrameOrigin(placement.bubbleOrigin)
        self.placement = placement
        updateClickThrough()
    }

    private func updateClickThrough() {
        let region: BubbleHitRegion = .init(panelFrame: bubblePanel.frame, bubbleFrames: bubbleFrames)
        let ignoresMouseEvents: Bool = !region.contains(NSEvent.mouseLocation)
        guard bubblePanel.ignoresMouseEvents != ignoresMouseEvents else { return }
        bubblePanel.ignoresMouseEvents = ignoresMouseEvents
    }
}

private extension Constants {
    static let characterSize: CGSize = .init(width: 64, height: 136)
    static let bubbleSize: CGSize = .init(width: 320, height: 144)
    static let margin: CGFloat = 12
    static let bubbleLift: CGFloat = 56
    static let trackedEvents: NSEvent.EventTypeMask = [.mouseMoved, .leftMouseDragged, .rightMouseDragged]
}
