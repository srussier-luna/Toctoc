//
//  EyeStyle.swift
//  Clippy
//
//  Created by Salomé Russier on 13/11/2026.
//

import CoreGraphics

struct EyeStyle: Equatable {
    let showsBrow: Bool
    let browAngle: Double
    let browLift: CGFloat
    let isHappy: Bool
    let looksAround: Bool
    let pupilOffset: CGSize

    init(
        showsBrow: Bool,
        browAngle: Double,
        browLift: CGFloat,
        isHappy: Bool,
        looksAround: Bool,
        pupilOffset: CGSize
    ) {
        self.showsBrow = showsBrow
        self.browAngle = browAngle
        self.browLift = browLift
        self.isHappy = isHappy
        self.looksAround = looksAround
        self.pupilOffset = pupilOffset
    }

    init(mood: Mood, side: EyeSide) {
        let mirror: Double = side == .left ? 1 : -1
        switch mood {
        case .idle:
            self.init(
                showsBrow: false,
                browAngle: .zero,
                browLift: .zero,
                isHappy: false,
                looksAround: false,
                pupilOffset: Constants.restingPupil
            )
        case .working:
            self.init(
                showsBrow: false,
                browAngle: .zero,
                browLift: .zero,
                isHappy: false,
                looksAround: true,
                pupilOffset: .zero
            )
        case .finished:
            self.init(
                showsBrow: false,
                browAngle: .zero,
                browLift: .zero,
                isHappy: true,
                looksAround: false,
                pupilOffset: .zero
            )
        case .waiting:
            self.init(
                showsBrow: true,
                browAngle: .zero,
                browLift: Constants.raisedBrowLift,
                isHappy: false,
                looksAround: false,
                pupilOffset: Constants.restingPupil
            )
        case .failed:
            self.init(
                showsBrow: true,
                browAngle: Constants.sadBrowAngle * mirror,
                browLift: .zero,
                isHappy: false,
                looksAround: false,
                pupilOffset: Constants.sadPupil
            )
        }
    }
}

private extension Constants {
    static let restingPupil: CGSize = .init(width: 0, height: 1)
    static let sadPupil: CGSize = .init(width: 0, height: 4)
    static let raisedBrowLift: CGFloat = -3
    static let sadBrowAngle: Double = -20
}
