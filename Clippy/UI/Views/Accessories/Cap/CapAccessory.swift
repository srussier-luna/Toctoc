//
//  CapAccessory.swift
//  Clippy
//
//  Created by Salomé Russier on 16/11/2026.
//

import SwiftUI

struct CapAccessory: View {
    var body: some View {
        ZStack {
            DomeShape()
                .fill(.linearGradient(colors: Constants.capColors, startPoint: .top, endPoint: .bottom))
                .frame(width: Constants.domeSize.width, height: Constants.domeSize.height)
                .offset(y: Constants.domeY)
            Capsule()
                .fill(Constants.brimColor)
                .frame(width: Constants.brimSize.width, height: Constants.brimSize.height)
            Circle()
                .fill(Constants.badgeColor)
                .frame(width: Constants.badgeSize, height: Constants.badgeSize)
                .overlay {
                    Text(Constants.letter)
                        .font(.system(size: Constants.letterSize, weight: .black, design: .rounded))
                        .foregroundStyle(Constants.letterColor)
                }
                .offset(y: Constants.badgeY)
        }
    }
}

private extension Constants {
    static let capColors: [Color] = [.init(red: 0.93, green: 0.2, blue: 0.2), .init(red: 0.8, green: 0.12, blue: 0.13)]
    static let brimColor: Color = .init(red: 0.68, green: 0.08, blue: 0.1)
    static let badgeColor: Color = .white
    static let letterColor: Color = .init(red: 0.86, green: 0.15, blue: 0.16)
    static let letter: String = "T"
    static let letterSize: CGFloat = 10
    static let domeSize: CGSize = .init(width: 36, height: 18)
    static let domeY: CGFloat = -9
    static let brimSize: CGSize = .init(width: 42, height: 6)
    static let badgeSize: CGFloat = 12
    static let badgeY: CGFloat = -9
}
