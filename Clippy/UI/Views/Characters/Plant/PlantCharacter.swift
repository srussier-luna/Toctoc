//
//  PlantCharacter.swift
//  Clippy
//
//  Created by Salomé Russier on 16/11/2026.
//

import SwiftUI

struct PlantCharacter<Accessory: View>: View {
    let mood: Mood

    private let accessory: Accessory

    init(mood: Mood, @ViewBuilder accessory: () -> Accessory) {
        self.mood = mood
        self.accessory = accessory()
    }

    var body: some View {
        VStack(spacing: Constants.stemOverlap) {
            ZStack {
                Circle()
                    .fill(Constants.petalColor)
                    .frame(width: Constants.flowerSize, height: Constants.flowerSize)
                    .overlay {
                        Circle()
                            .fill(Constants.heartColor)
                            .frame(width: Constants.heartSize, height: Constants.heartSize)
                    }
                    .offset(y: Constants.flowerY)
                    .opacity(mood == .finished ? 1 : 0)
                ZStack {
                    LeafShape()
                        .fill(Constants.leftLeafColor)
                        .frame(width: Constants.leafSize.width, height: Constants.leafSize.height)
                    EyeView(style: .init(mood: mood, side: .left))
                        .offset(x: Constants.eyeShift)
                }
                .rotationEffect(.degrees(-leafLift), anchor: .trailing)
                .offset(x: -Constants.leafX)
                ZStack {
                    LeafShape()
                        .fill(Constants.rightLeafColor)
                        .frame(width: Constants.leafSize.width, height: Constants.leafSize.height)
                    EyeView(style: .init(mood: mood, side: .right))
                        .offset(x: -Constants.eyeShift)
                }
                .rotationEffect(.degrees(leafLift), anchor: .leading)
                .offset(x: Constants.leafX)
            }
            .frame(height: Constants.leavesHeight)
            Capsule()
                .fill(Constants.stemColor)
                .frame(width: Constants.stemSize.width, height: Constants.stemSize.height)
            PotShape()
                .fill(.linearGradient(colors: Constants.potColors, startPoint: .top, endPoint: .bottom))
                .frame(width: Constants.potSize.width, height: Constants.potSize.height)
        }
        .frame(width: Constants.size.width, height: Constants.size.height, alignment: .bottom)
        .overlay {
            accessory
                .offset(y: leafRise)
        }
    }

    private var leafLift: Double {
        switch mood {
        case .working: Constants.raisedLift
        case .failed: Constants.droopLift
        case .idle, .finished, .waiting: Constants.restingLift
        }
    }

    private var leafRise: CGFloat {
        Constants.eyeReach * (sin(Angle.degrees(leafLift).radians) - sin(Angle.degrees(Constants.restingLift).radians))
    }
}

private extension Constants {
    static let size: CGSize = .init(width: 60, height: 76)
    static let leafSize: CGSize = .init(width: 30, height: 22)
    static let leafX: CGFloat = 14
    static let leftLeafColor: Color = .init(red: 0.42, green: 0.74, blue: 0.38)
    static let rightLeafColor: Color = .init(red: 0.36, green: 0.68, blue: 0.34)
    static let eyeShift: CGFloat = 2
    static let eyeReach: CGFloat = leafSize.width / 2 - eyeShift
    static let leavesHeight: CGFloat = 32
    static let raisedLift: Double = -18
    static let droopLift: Double = 22
    static let restingLift: Double = -6
    static let petalColor: Color = .pink
    static let heartColor: Color = .yellow
    static let flowerSize: CGFloat = 11
    static let heartSize: CGFloat = 4
    static let flowerY: CGFloat = -18
    static let stemColor: Color = .init(red: 0.3, green: 0.58, blue: 0.3)
    static let stemSize: CGSize = .init(width: 4, height: 24)
    static let stemOverlap: CGFloat = -12
    static let potColors: [Color] = [.init(red: 0.86, green: 0.48, blue: 0.3), .init(red: 0.7, green: 0.35, blue: 0.2)]
    static let potSize: CGSize = .init(width: 26, height: 18)
}
