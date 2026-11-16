//
//  AccessoryLayout.swift
//  Clippy
//
//  Created by Salomé Russier on 16/11/2026.
//

import CoreGraphics

struct AccessoryLayout {
    let cap: AccessoryPlacement
    let glasses: AccessoryPlacement
    let bowTie: AccessoryPlacement
    let headphones: AccessoryPlacement
    let beanie: AccessoryPlacement
    let scarf: AccessoryPlacement
    let mustache: AccessoryPlacement
    let flower: AccessoryPlacement
    let spoon: AccessoryPlacement?

    init(
        cap: AccessoryPlacement,
        glasses: AccessoryPlacement,
        bowTie: AccessoryPlacement,
        headphones: AccessoryPlacement,
        beanie: AccessoryPlacement,
        scarf: AccessoryPlacement,
        mustache: AccessoryPlacement,
        flower: AccessoryPlacement,
        spoon: AccessoryPlacement? = nil
    ) {
        self.cap = cap
        self.glasses = glasses
        self.bowTie = bowTie
        self.headphones = headphones
        self.beanie = beanie
        self.scarf = scarf
        self.mustache = mustache
        self.flower = flower
        self.spoon = spoon
    }

    init(_ character: CharacterKind) {
        switch character {
        case .paperclip: self = Constants.paperclip
        case .otter: self = Constants.otter
        case .owl: self = Constants.owl
        case .cup: self = Constants.cup
        case .cloud: self = Constants.cloud
        case .plant: self = Constants.plant
        case .tiger: self = Constants.tiger
        }
    }

    func placement(for accessory: AccessoryKind) -> AccessoryPlacement? {
        switch accessory {
        case .cap: cap
        case .glasses: glasses
        case .bowTie: bowTie
        case .headphones: headphones
        case .beanie: beanie
        case .scarf: scarf
        case .mustache: mustache
        case .flower: flower
        case .spoon: spoon
        }
    }
}

private extension Constants {
    static let paperclip: AccessoryLayout = .init(
        cap: .init(offsetX: 5, offsetY: -47, scale: 0.9),
        glasses: .init(offsetX: 5, offsetY: -30),
        bowTie: .init(offsetX: 5, offsetY: -8, scale: 0.8),
        headphones: .init(offsetX: 5, offsetY: -37, scale: 0.7),
        beanie: .init(offsetX: 5, offsetY: -42, scale: 0.8),
        scarf: .init(offsetX: 5, offsetY: -12, scale: 0.9),
        mustache: .init(offsetX: 5, offsetY: -17, scale: 0.8),
        flower: .init(offsetX: -6, offsetY: -46, angle: -20)
    )
    static let otter: AccessoryLayout = .init(
        cap: .init(offsetX: 0, offsetY: -33, scale: 1.1),
        glasses: .init(offsetX: 0, offsetY: -19.25),
        bowTie: .init(offsetX: 0, offsetY: 10),
        headphones: .init(offsetX: 0, offsetY: -15, scale: 0.95),
        beanie: .init(offsetX: 0, offsetY: -30, scale: 1.15),
        scarf: .init(offsetX: 0, offsetY: 8),
        mustache: .init(offsetX: 0, offsetY: 2.5, scale: 0.95),
        flower: .init(offsetX: -19, offsetY: -29, angle: -15)
    )
    static let owl: AccessoryLayout = .init(
        cap: .init(offsetX: 0, offsetY: -24, scale: 1.1),
        glasses: .init(offsetX: 0, offsetY: -5.25),
        bowTie: .init(offsetX: 0, offsetY: 15, scale: 0.9),
        headphones: .init(offsetX: 0, offsetY: -4, scale: 0.95),
        beanie: .init(offsetX: 0, offsetY: -22, scale: 1.15),
        scarf: .init(offsetX: 0, offsetY: 11, scale: 0.95),
        mustache: .init(offsetX: 0, offsetY: 9, scale: 0.75),
        flower: .init(offsetX: -15, offsetY: -24, angle: -15)
    )
    static let cup: AccessoryLayout = .init(
        cap: .init(offsetX: 0, offsetY: -20, scale: 1.15),
        glasses: .init(offsetX: 0, offsetY: 5.75),
        bowTie: .init(offsetX: 24, offsetY: 0, scale: 0.7),
        headphones: .init(offsetX: 2, offsetY: -7, scale: 0.85),
        beanie: .init(offsetX: 0, offsetY: -19, scale: 1.1),
        scarf: .init(offsetX: 0, offsetY: -11, scale: 0.97),
        mustache: .init(offsetX: 0, offsetY: 15.5, scale: 0.75),
        flower: .init(offsetX: -17, offsetY: -20, angle: -20),
        spoon: .init(offsetX: 8, offsetY: -16, angle: 22)
    )
    static let cloud: AccessoryLayout = .init(
        cap: .init(offsetX: 4, offsetY: -20),
        glasses: .init(offsetX: 1, offsetY: 3.75),
        bowTie: .init(offsetX: 1, offsetY: 13, scale: 0.8),
        headphones: .init(offsetX: 1, offsetY: 0, scale: 0.92),
        beanie: .init(offsetX: 4, offsetY: -18),
        scarf: .init(offsetX: 1, offsetY: 11),
        mustache: .init(offsetX: 1, offsetY: 13, scale: 0.8),
        flower: .init(offsetX: -14, offsetY: -12, angle: -20)
    )
    static let plant: AccessoryLayout = .init(
        cap: .init(offsetX: 0, offsetY: -5, scale: 0.75),
        glasses: .init(offsetX: 0, offsetY: 4.4, scale: 1.2),
        bowTie: .init(offsetX: 0, offsetY: 15, scale: 0.6),
        headphones: .init(offsetX: 0, offsetY: 3, scale: 0.95),
        beanie: .init(offsetX: 0, offsetY: -4, scale: 0.75),
        scarf: .init(offsetX: 0, offsetY: 15, scale: 0.6),
        mustache: .init(offsetX: 0, offsetY: 13, scale: 0.7),
        flower: .init(offsetX: -22, offsetY: -3, angle: -20)
    )
    static let tiger: AccessoryLayout = .init(
        cap: .init(offsetX: 0, offsetY: -33, scale: 1.15),
        glasses: .init(offsetX: 0, offsetY: -18.25),
        bowTie: .init(offsetX: 0, offsetY: 11),
        headphones: .init(offsetX: 0, offsetY: -14, scale: 0.95),
        beanie: .init(offsetX: 0, offsetY: -30, scale: 1.2),
        scarf: .init(offsetX: 0, offsetY: 9),
        mustache: .init(offsetX: 0, offsetY: 3.5),
        flower: .init(offsetX: -19, offsetY: -31, angle: -15)
    )
}
