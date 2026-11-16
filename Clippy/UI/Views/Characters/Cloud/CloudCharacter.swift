//
//  CloudCharacter.swift
//  Clippy
//
//  Created by Salomé Russier on 16/11/2026.
//

import SwiftUI

struct CloudCharacter: View {
    let mood: Mood

    var body: some View {
        ZStack {
            Circle()
                .fill(Constants.sunColor)
                .frame(width: Constants.sunSize, height: Constants.sunSize)
                .offset(x: Constants.sunOffset.width, y: Constants.sunOffset.height)
                .opacity(mood == .finished ? 1 : 0)
            ZStack {
                Circle()
                    .frame(width: Constants.leftPuff, height: Constants.leftPuff)
                    .offset(x: Constants.leftPuffOffset.width, y: Constants.leftPuffOffset.height)
                Circle()
                    .frame(width: Constants.topPuff, height: Constants.topPuff)
                    .offset(x: Constants.topPuffOffset.width, y: Constants.topPuffOffset.height)
                Circle()
                    .frame(width: Constants.rightPuff, height: Constants.rightPuff)
                    .offset(x: Constants.rightPuffOffset.width, y: Constants.rightPuffOffset.height)
                Capsule()
                    .frame(width: Constants.baseSize.width, height: Constants.baseSize.height)
                    .offset(y: Constants.baseY)
            }
            .foregroundStyle(mood == .failed ? Constants.rainyColor : Constants.cloudColor)
            EyePairView(mood: mood)
                .offset(x: Constants.eyesOffset.width, y: Constants.eyesOffset.height)
            HStack(spacing: Constants.dropSpacing) {
                ForEach(0..<Constants.dropCount, id: \.self) { _ in
                    Capsule()
                        .fill(Constants.dropColor)
                        .frame(width: Constants.dropSize.width, height: Constants.dropSize.height)
                }
            }
            .offset(y: Constants.rainY)
            .opacity(mood == .failed ? 1 : 0)
        }
        .frame(width: Constants.size.width, height: Constants.size.height)
    }
}

private extension Constants {
    static let size: CGSize = .init(width: 60, height: 64)
    static let cloudColor: Color = .init(white: 0.98)
    static let rainyColor: Color = .init(white: 0.75)
    static let leftPuff: CGFloat = 27
    static let leftPuffOffset: CGSize = .init(width: -12, height: 1)
    static let topPuff: CGFloat = 33
    static let topPuffOffset: CGSize = .init(width: 4, height: -6)
    static let rightPuff: CGFloat = 23
    static let rightPuffOffset: CGSize = .init(width: 17, height: 4)
    static let baseSize: CGSize = .init(width: 58, height: 20)
    static let baseY: CGFloat = 7
    static let eyesOffset: CGSize = .init(width: 1, height: 2)
    static let sunColor: Color = .yellow
    static let sunSize: CGFloat = 20
    static let sunOffset: CGSize = .init(width: 18, height: -20)
    static let dropCount: Int = 3
    static let dropColor: Color = .blue.opacity(0.6)
    static let dropSize: CGSize = .init(width: 2.5, height: 7)
    static let dropSpacing: CGFloat = 9
    static let rainY: CGFloat = 26
}
