//
//  EyePairView.swift
//  Clippy
//
//  Created by Salomé Russier on 16/11/2026.
//

import SwiftUI

struct EyePairView: View {
    let mood: Mood

    var body: some View {
        HStack(spacing: Constants.spacing) {
            EyeView(style: .init(mood: mood, side: .left))
            EyeView(style: .init(mood: mood, side: .right))
        }
    }
}

private extension Constants {
    static let spacing: CGFloat = 1
}
