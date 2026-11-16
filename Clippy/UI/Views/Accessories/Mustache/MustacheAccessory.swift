//
//  MustacheAccessory.swift
//  Clippy
//
//  Created by Salomé Russier on 16/11/2026.
//

import SwiftUI

struct MustacheAccessory: View {
    var body: some View {
        MustacheShape()
            .fill(Constants.color)
            .frame(width: Constants.size.width, height: Constants.size.height)
    }
}

private extension Constants {
    static let color: Color = .init(red: 0.24, green: 0.14, blue: 0.08)
    static let size: CGSize = .init(width: 32, height: 11)
}
