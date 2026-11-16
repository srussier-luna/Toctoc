//
//  AccessoryView.swift
//  Clippy
//
//  Created by Salomé Russier on 16/11/2026.
//

import SwiftUI

struct AccessoryView: View {
    let kind: AccessoryKind

    init(_ kind: AccessoryKind) {
        self.kind = kind
    }

    var body: some View {
        switch kind {
        case .cap:
            CapAccessory()
        case .glasses:
            GlassesAccessory()
        case .bowTie:
            BowTieAccessory()
        case .headphones:
            HeadphonesAccessory()
        case .beanie:
            BeanieAccessory()
        case .scarf:
            ScarfAccessory()
        case .mustache:
            MustacheAccessory()
        case .flower:
            FlowerAccessory()
        case .spoon:
            SpoonAccessory()
        }
    }
}
