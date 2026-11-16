//
//  NSScreenExtension.swift
//  Clippy
//
//  Created by Salomé Russier on 16/11/2026.
//

import AppKit

extension NSScreen {
    var overlayScreen: OverlayScreen? {
        guard let number = deviceDescription[Constants.screenNumberKey] as? NSNumber else { return nil }
        return .init(id: number.uint32Value, visibleFrame: visibleFrame)
    }
}

private extension Constants {
    static let screenNumberKey: NSDeviceDescriptionKey = .init("NSScreenNumber")
}
