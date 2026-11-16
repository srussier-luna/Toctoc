//
//  PaperclipCharacter.swift
//  Clippy
//
//  Created by Salomé Russier on 13/11/2026.
//

import SwiftUI

struct PaperclipCharacter: View {
    let mood: Mood

    var body: some View {
        ZStack(alignment: .top) {
            PaperclipShape()
                .stroke(
                    .linearGradient(colors: Constants.wireColors, startPoint: .topLeading, endPoint: .bottomTrailing),
                    style: .init(lineWidth: Constants.wireWidth, lineCap: .round, lineJoin: .round)
                )
            EyePairView(mood: mood)
                .padding(.top, Constants.eyesTop)
                .offset(x: Constants.eyesShift)
        }
        .frame(width: Constants.size.width, height: Constants.size.height)
    }
}

private extension Constants {
    static let size: CGSize = .init(width: 48, height: 110)
    static let wireColors: [Color] = [.init(white: 0.85), .init(white: 0.5)]
    static let wireWidth: CGFloat = 5
    static let eyesTop: CGFloat = 13
    static let eyesShift: CGFloat = 5
}
