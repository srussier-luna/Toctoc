//
//  ScarfAccessory.swift
//  Clippy
//
//  Created by Salomé Russier on 16/11/2026.
//

import SwiftUI

struct ScarfAccessory: View {
    var body: some View {
        ZStack {
            VStack(spacing: Constants.fringeGap) {
                VStack(spacing: Constants.stripeGap) {
                    ForEach(0..<Constants.tailStripeCount, id: \.self) { _ in
                        Rectangle()
                            .fill(Constants.stripeColor)
                            .frame(height: Constants.stripeWidth)
                    }
                }
                .frame(width: Constants.tailSize.width, height: Constants.tailSize.height)
                .background(Constants.scarfColor)
                .clipShape(.rect(cornerRadius: Constants.tailRadius))
                HStack(spacing: Constants.fringeSpacing) {
                    ForEach(0..<Constants.fringeCount, id: \.self) { _ in
                        Capsule()
                            .fill(Constants.scarfColor)
                            .frame(width: Constants.fringeSize.width, height: Constants.fringeSize.height)
                    }
                }
            }
            .rotationEffect(.degrees(Constants.tailAngle), anchor: .top)
            .offset(x: Constants.tailX, y: Constants.tailY)
            HStack(spacing: Constants.stripeGap) {
                ForEach(0..<Constants.bandStripeCount, id: \.self) { _ in
                    Rectangle()
                        .fill(Constants.stripeColor)
                        .frame(width: Constants.stripeWidth)
                }
            }
            .frame(width: Constants.bandSize.width, height: Constants.bandSize.height)
            .background(Constants.scarfColor)
            .clipShape(.capsule)
        }
    }
}

private extension Constants {
    static let scarfColor: Color = .init(red: 0.86, green: 0.22, blue: 0.24)
    static let stripeColor: Color = .init(red: 0.99, green: 0.95, blue: 0.88)
    static let bandSize: CGSize = .init(width: 46, height: 9)
    static let bandStripeCount: Int = 6
    static let stripeWidth: CGFloat = 3
    static let stripeGap: CGFloat = 4
    static let tailSize: CGSize = .init(width: 9, height: 10)
    static let tailRadius: CGFloat = 2.5
    static let tailStripeCount: Int = 1
    static let tailAngle: Double = -8
    static let tailX: CGFloat = 17
    static let tailY: CGFloat = 8
    static let fringeCount: Int = 3
    static let fringeSize: CGSize = .init(width: 1.5, height: 3)
    static let fringeSpacing: CGFloat = 1.5
    static let fringeGap: CGFloat = 0.5
}
