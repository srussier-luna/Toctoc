//
//  EyeView.swift
//  Clippy
//
//  Created by Salomé Russier on 13/11/2026.
//

import SwiftUI

struct EyeView: View {
    let style: EyeStyle

    var body: some View {
        VStack(spacing: Constants.browSpacing) {
            Capsule()
                .fill(.black)
                .frame(width: Constants.browSize.width, height: Constants.browSize.height)
                .rotationEffect(.degrees(style.browAngle))
                .offset(y: style.browLift)
                .opacity(style.showsBrow ? 1 : 0)
            if style.isHappy {
                HappyEyeShape()
                    .stroke(.black, style: .init(lineWidth: Constants.happyLineWidth, lineCap: .round))
                    .frame(width: Constants.eyeSize.width, height: Constants.happyHeight)
                    .frame(height: Constants.eyeSize.height)
            } else {
                ZStack {
                    Ellipse()
                        .fill(.white)
                    Ellipse()
                        .strokeBorder(.black.opacity(Constants.outlineOpacity), lineWidth: Constants.outlineWidth)
                    Circle()
                        .fill(.black)
                        .frame(width: Constants.pupilSize, height: Constants.pupilSize)
                        .offset(style.pupilOffset)
                        .modifier(LookAroundModifier(isActive: style.looksAround))
                }
                .frame(width: Constants.eyeSize.width, height: Constants.eyeSize.height)
                .modifier(BlinkModifier())
            }
        }
    }
}

private extension Constants {
    static let browSpacing: CGFloat = 1
    static let browSize: CGSize = .init(width: 11, height: 2.5)
    static let eyeSize: CGSize = .init(width: 15, height: 17)
    static let happyHeight: CGFloat = 6
    static let happyLineWidth: CGFloat = 2.5
    static let outlineOpacity: Double = 0.85
    static let outlineWidth: CGFloat = 1.2
    static let pupilSize: CGFloat = 6
}
