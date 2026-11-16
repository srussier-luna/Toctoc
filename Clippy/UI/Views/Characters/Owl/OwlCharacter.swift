//
//  OwlCharacter.swift
//  Clippy
//
//  Created by Salomé Russier on 16/11/2026.
//

import SwiftUI

struct OwlCharacter: View {
    let mood: Mood

    var body: some View {
        ZStack {
            ForEach(Constants.mirrors, id: \.self) { mirror in
                TriangleShape()
                    .fill(Constants.featherColor)
                    .frame(width: Constants.earSize.width, height: Constants.earSize.height)
                    .rotationEffect(.degrees(mirror * Constants.earAngle))
                    .offset(x: mirror * Constants.earX, y: Constants.earY)
            }
            Circle()
                .fill(.linearGradient(colors: Constants.bodyColors, startPoint: .top, endPoint: .bottom))
                .frame(width: Constants.bodySize, height: Constants.bodySize)
            Circle()
                .fill(Constants.bellyColor)
                .frame(width: Constants.bellySize, height: Constants.bellySize)
                .offset(y: Constants.bellyY)
            ForEach(Constants.mirrors, id: \.self) { mirror in
                Capsule()
                    .fill(Constants.wingColor)
                    .frame(width: Constants.wingSize.width, height: Constants.wingSize.height)
                    .rotationEffect(.degrees(-mirror * wingAngle))
                    .offset(x: mirror * Constants.wingX, y: mood == .finished ? Constants.raisedWingsY : Constants.wingsY)
            }
            EyePairView(mood: mood)
                .offset(y: Constants.eyesY)
            TriangleShape()
                .fill(Constants.beakColor)
                .frame(width: Constants.beakSize.width, height: Constants.beakSize.height)
                .rotationEffect(.degrees(Constants.beakAngle))
                .offset(y: Constants.beakY)
        }
        .frame(width: Constants.size.width, height: Constants.size.height)
    }

    private var wingAngle: Double {
        mood == .finished ? Constants.raisedWingAngle : Constants.wingAngle
    }
}

private extension Constants {
    static let size: CGSize = .init(width: 60, height: 54)
    static let mirrors: [Double] = [-1, 1]
    static let bodySize: CGFloat = 52
    static let bodyColors: [Color] = [.init(red: 0.66, green: 0.47, blue: 0.32), .init(red: 0.48, green: 0.32, blue: 0.21)]
    static let featherColor: Color = .init(red: 0.5, green: 0.34, blue: 0.22)
    static let wingColor: Color = .init(red: 0.48, green: 0.32, blue: 0.21)
    static let bellyColor: Color = .init(red: 0.95, green: 0.88, blue: 0.75)
    static let beakColor: Color = .orange
    static let earSize: CGSize = .init(width: 11, height: 10)
    static let earX: CGFloat = 15
    static let earAngle: Double = 18
    static let earY: CGFloat = -24
    static let bellySize: CGFloat = 30
    static let bellyY: CGFloat = 11
    static let wingSize: CGSize = .init(width: 10, height: 20)
    static let wingX: CGFloat = 23
    static let wingAngle: Double = 10
    static let raisedWingAngle: Double = 40
    static let wingsY: CGFloat = 6
    static let raisedWingsY: CGFloat = -8
    static let eyesY: CGFloat = -7
    static let beakSize: CGSize = .init(width: 7, height: 5)
    static let beakAngle: Double = 180
    static let beakY: CGFloat = 5
}
