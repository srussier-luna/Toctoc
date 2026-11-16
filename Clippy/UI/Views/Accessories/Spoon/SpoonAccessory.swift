//
//  SpoonAccessory.swift
//  Clippy
//
//  Created by Salomé Russier on 16/11/2026.
//

import SwiftUI

struct SpoonAccessory: View {
    var body: some View {
        ZStack {
            Capsule()
                .fill(.linearGradient(colors: Constants.silverColors, startPoint: .leading, endPoint: .trailing))
                .frame(width: Constants.handleSize.width, height: Constants.handleSize.height)
                .offset(y: Constants.handleY)
            Ellipse()
                .fill(.linearGradient(colors: Constants.silverColors, startPoint: .leading, endPoint: .trailing))
                .frame(width: Constants.tipSize.width, height: Constants.tipSize.height)
                .offset(y: Constants.tipY)
        }
    }
}

private extension Constants {
    static let silverColors: [Color] = [.init(white: 0.94), .init(white: 0.6)]
    static let handleSize: CGSize = .init(width: 3.5, height: 24)
    static let handleY: CGFloat = -12
    static let tipSize: CGSize = .init(width: 6, height: 9)
    static let tipY: CGFloat = -22
}
