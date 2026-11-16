//
//  OtterShellView.swift
//  Clippy
//
//  Created by Salomé Russier on 16/11/2026.
//

import SwiftUI

struct OtterShellView: View {
    var body: some View {
        ZStack(alignment: .bottom) {
            ShellShape()
                .fill(Constants.shellColor)
            ForEach(Constants.ribAngles, id: \.self) { angle in
                Capsule()
                    .fill(Constants.ribColor)
                    .frame(width: Constants.ribWidth, height: Constants.ribLength)
                    .rotationEffect(.degrees(angle), anchor: .bottom)
            }
        }
        .frame(width: Constants.size.width, height: Constants.size.height)
    }
}

private extension Constants {
    static let size: CGSize = .init(width: 20, height: 16)
    static let shellColor: Color = .init(red: 0.98, green: 0.78, blue: 0.7)
    static let ribColor: Color = .init(red: 0.85, green: 0.55, blue: 0.48)
    static let ribAngles: [Double] = [-38, -19, 0, 19, 38]
    static let ribWidth: CGFloat = 1
    static let ribLength: CGFloat = 13
}
