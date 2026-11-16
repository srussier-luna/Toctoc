//
//  BowTieAccessory.swift
//  Clippy
//
//  Created by Salomé Russier on 16/11/2026.
//

import SwiftUI

struct BowTieAccessory: View {
    var body: some View {
        ZStack {
            BowTieShape()
                .fill(Constants.tieColor)
                .overlay {
                    BowTieShape()
                        .stroke(Constants.tieColor, style: .init(lineWidth: Constants.edgeWidth, lineJoin: .round))
                }
                .frame(width: Constants.size.width, height: Constants.size.height)
            RoundedRectangle(cornerRadius: Constants.knotRadius)
                .fill(Constants.knotColor)
                .frame(width: Constants.knotSize.width, height: Constants.knotSize.height)
        }
    }
}

private extension Constants {
    static let tieColor: Color = .init(red: 0.88, green: 0.2, blue: 0.36)
    static let knotColor: Color = .init(red: 0.7, green: 0.12, blue: 0.26)
    static let size: CGSize = .init(width: 24, height: 13)
    static let edgeWidth: CGFloat = 2.5
    static let knotSize: CGSize = .init(width: 6, height: 8)
    static let knotRadius: CGFloat = 2
}
