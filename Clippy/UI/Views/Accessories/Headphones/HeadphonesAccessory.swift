//
//  HeadphonesAccessory.swift
//  Clippy
//
//  Created by Salomé Russier on 16/11/2026.
//

import SwiftUI

struct HeadphonesAccessory: View {
    var body: some View {
        ZStack {
            Ellipse()
                .trim(from: Constants.bandStart, to: Constants.bandEnd)
                .stroke(Constants.bandColor, style: .init(lineWidth: Constants.bandWidth, lineCap: .round))
                .frame(width: Constants.bandSize.width, height: Constants.bandSize.height)
            ForEach(Constants.mirrors, id: \.self) { mirror in
                Capsule()
                    .fill(Constants.cupColor)
                    .overlay {
                        Capsule()
                            .fill(Constants.padColor)
                            .frame(width: Constants.padSize.width, height: Constants.padSize.height)
                    }
                    .frame(width: Constants.cupSize.width, height: Constants.cupSize.height)
                    .offset(x: mirror * Constants.cupX, y: Constants.cupY)
            }
        }
    }
}

private extension Constants {
    static let mirrors: [CGFloat] = [-1, 1]
    static let bandColor: Color = .init(white: 0.18)
    static let cupColor: Color = .init(white: 0.2)
    static let padColor: Color = .init(red: 0.35, green: 0.68, blue: 0.95)
    static let bandStart: CGFloat = 0.5
    static let bandEnd: CGFloat = 1
    static let bandWidth: CGFloat = 3.5
    static let bandSize: CGSize = .init(width: 54, height: 44)
    static let cupSize: CGSize = .init(width: 10, height: 16)
    static let padSize: CGSize = .init(width: 5, height: 10)
    static let cupX: CGFloat = 27
    static let cupY: CGFloat = 2
}
