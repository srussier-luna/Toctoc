//
//  BeanieAccessory.swift
//  Clippy
//
//  Created by Salomé Russier on 16/11/2026.
//

import SwiftUI

struct BeanieAccessory: View {
    var body: some View {
        ZStack {
            DomeShape()
                .fill(.linearGradient(colors: Constants.beanieColors, startPoint: .top, endPoint: .bottom))
                .frame(width: Constants.domeSize.width, height: Constants.domeSize.height)
                .offset(y: Constants.domeY)
            RoundedRectangle(cornerRadius: Constants.cuffRadius)
                .fill(Constants.cuffColor)
                .frame(width: Constants.cuffSize.width, height: Constants.cuffSize.height)
            ForEach(Constants.ribs, id: \.self) { ribX in
                Capsule()
                    .fill(Constants.ribColor)
                    .frame(width: Constants.ribSize.width, height: Constants.ribSize.height)
                    .offset(x: ribX)
            }
            Circle()
                .fill(Constants.pompomColor)
                .frame(width: Constants.pompomSize, height: Constants.pompomSize)
                .offset(y: Constants.pompomY)
        }
    }
}

private extension Constants {
    static let beanieColors: [Color] = [.init(red: 0.32, green: 0.56, blue: 0.9), .init(red: 0.22, green: 0.44, blue: 0.8)]
    static let cuffColor: Color = .init(red: 0.2, green: 0.38, blue: 0.72)
    static let ribColor: Color = .init(red: 0.15, green: 0.3, blue: 0.6)
    static let pompomColor: Color = .init(white: 0.97)
    static let domeSize: CGSize = .init(width: 38, height: 20)
    static let domeY: CGFloat = -12
    static let cuffSize: CGSize = .init(width: 42, height: 9)
    static let cuffRadius: CGFloat = 4
    static let ribs: [CGFloat] = [-14, -7, 0, 7, 14]
    static let ribSize: CGSize = .init(width: 1.5, height: 5)
    static let pompomSize: CGFloat = 10
    static let pompomY: CGFloat = -24
}
