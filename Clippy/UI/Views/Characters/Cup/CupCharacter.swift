//
//  CupCharacter.swift
//  Clippy
//
//  Created by Salomé Russier on 16/11/2026.
//

import SwiftUI

struct CupCharacter<Accessory: View>: View {
    let mood: Mood

    private let accessory: Accessory

    init(mood: Mood, @ViewBuilder accessory: () -> Accessory) {
        self.mood = mood
        self.accessory = accessory()
    }

    var body: some View {
        VStack(spacing: Constants.steamGap) {
            HStack(spacing: Constants.steamSpacing) {
                ForEach(0..<Constants.steamCount, id: \.self) { _ in
                    Capsule()
                        .fill(Constants.steamColor)
                        .frame(width: Constants.steamSize.width, height: Constants.steamSize.height)
                }
            }
            .opacity(mood == .working ? 1 : 0)
            ZStack {
                Circle()
                    .stroke(Constants.cupColor, lineWidth: Constants.handleWidth)
                    .frame(width: Constants.handleSize, height: Constants.handleSize)
                    .offset(x: Constants.handleX, y: Constants.handleY)
                RoundedRectangle(cornerRadius: Constants.cornerRadius)
                    .fill(Constants.cupColor)
                    .overlay {
                        RoundedRectangle(cornerRadius: Constants.cornerRadius)
                            .stroke(Constants.rimColor, lineWidth: Constants.rimWidth)
                    }
                    .frame(width: Constants.cupSize.width, height: Constants.cupSize.height)
                Ellipse()
                    .fill(mood == .waiting ? Constants.emptyColor : Constants.coffeeColor)
                    .frame(width: Constants.coffeeSize.width, height: Constants.coffeeSize.height)
                    .offset(y: Constants.coffeeY)
                EyePairView(mood: mood)
                    .offset(y: Constants.eyesY)
            }
            .overlay {
                accessory
            }
            .rotationEffect(.degrees(mood == .failed ? Constants.spillAngle : .zero))
            .offset(y: mood == .failed ? Constants.spillLift : .zero)
        }
        .offset(x: Constants.shift)
        .frame(width: Constants.size.width, height: Constants.size.height, alignment: .bottom)
    }
}

private extension Constants {
    static let size: CGSize = .init(width: 60, height: 58)
    static let shift: CGFloat = -5
    static let cupSize: CGSize = .init(width: 44, height: 40)
    static let cornerRadius: CGFloat = 10
    static let cupColor: Color = .init(red: 0.97, green: 0.96, blue: 0.94)
    static let rimColor: Color = .init(white: 0.75)
    static let rimWidth: CGFloat = 1
    static let handleSize: CGFloat = 15
    static let handleWidth: CGFloat = 4
    static let handleX: CGFloat = 24
    static let handleY: CGFloat = -2
    static let coffeeColor: Color = .init(red: 0.42, green: 0.26, blue: 0.15)
    static let emptyColor: Color = .init(white: 0.85)
    static let coffeeSize: CGSize = .init(width: 38, height: 7)
    static let coffeeY: CGFloat = -15
    static let eyesY: CGFloat = 4
    static let spillAngle: Double = 25
    static let spillLift: CGFloat = -8
    static let steamCount: Int = 3
    static let steamColor: Color = .init(white: 0.7).opacity(0.9)
    static let steamSize: CGSize = .init(width: 3, height: 12)
    static let steamSpacing: CGFloat = 5
    static let steamGap: CGFloat = 2
}
