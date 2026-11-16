//
//  BubbleView.swift
//  Clippy
//
//  Created by Salomé Russier on 13/11/2026.
//

import SwiftUI

struct BubbleView: View {
    private let message: String

    private var isMultiline: Bool = false

    init(_ message: String) {
        self.message = message
    }

    var body: some View {
        Text(message)
            .font(.callout)
            .lineLimit(isMultiline ? nil : 1)
            .truncationMode(.middle)
            .padding(.horizontal)
            .padding(.vertical, Constants.verticalPadding)
            .background(.background, in: .capsule)
            .overlay {
                Capsule()
                    .strokeBorder(.separator)
            }
            .shadow(color: .black.opacity(Constants.shadowOpacity), radius: Constants.shadowRadius, y: Constants.shadowOffset)
    }
}

extension BubbleView {
    func multiline(_ isMultiline: Bool = true) -> Self {
        var copy: Self = self
        copy.isMultiline = isMultiline
        return copy
    }
}

private extension Constants {
    static let verticalPadding: CGFloat = 8
    static let shadowOpacity: Double = 0.2
    static let shadowRadius: CGFloat = 4
    static let shadowOffset: CGFloat = 1
}
