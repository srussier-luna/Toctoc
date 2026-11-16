//
//  OtterCharacter.swift
//  Clippy
//
//  Created by Salomé Russier on 16/11/2026.
//

import SwiftUI

struct OtterCharacter<Accessory: View>: View {
    let mood: Mood

    private let accessory: Accessory

    init(mood: Mood, @ViewBuilder accessory: () -> Accessory) {
        self.mood = mood
        self.accessory = accessory()
    }

    var body: some View {
        ZStack {
            ZStack {
                ForEach(Constants.mirrors, id: \.self) { mirror in
                    Circle()
                        .fill(Constants.darkFurColor)
                        .frame(width: Constants.earSize, height: Constants.earSize)
                        .overlay {
                            Circle()
                                .fill(Constants.innerEarColor)
                                .frame(width: Constants.innerEarSize, height: Constants.innerEarSize)
                        }
                        .offset(x: mirror * Constants.earX, y: Constants.earY)
                }
                Ellipse()
                    .fill(.linearGradient(colors: Constants.bodyColors, startPoint: .top, endPoint: .bottom))
                    .frame(width: Constants.bodySize.width, height: Constants.bodySize.height)
                    .offset(y: Constants.bodyY)
                Ellipse()
                    .fill(Constants.bellyColor)
                    .frame(width: Constants.bellySize.width, height: Constants.bellySize.height)
                    .offset(y: Constants.bellyY)
                Ellipse()
                    .fill(.linearGradient(colors: Constants.headColors, startPoint: .top, endPoint: .bottom))
                    .frame(width: Constants.headSize.width, height: Constants.headSize.height)
                    .offset(y: Constants.headY)
                MuzzleView(color: Constants.muzzleColor, noseColor: Constants.noseColor)
                    .offset(y: Constants.muzzleY)
                EyePairView(mood: mood)
                    .offset(y: Constants.eyesY)
                OtterShellView()
                    .offset(y: Constants.shellY)
                    .opacity(mood == .finished ? 1 : 0)
                OtterPawsView(isPaddling: mood == .working)
                    .offset(y: Constants.pawsY)
                Capsule()
                    .fill(Constants.waterColor)
                    .frame(width: Constants.waterSize.width, height: Constants.waterSize.height)
                    .offset(y: Constants.waterY)
                    .opacity(mood == .working ? 1 : 0)
            }
            .overlay {
                accessory
            }
            .rotationEffect(.degrees(mood == .failed ? Constants.shakeTilt : .zero), anchor: .bottom)
            .offset(x: mood == .failed ? Constants.shakeShift : .zero)
            ForEach(Constants.drops, id: \.self) { drop in
                Ellipse()
                    .fill(Constants.dropColor)
                    .frame(width: Constants.dropSize.width, height: Constants.dropSize.height)
                    .rotationEffect(.degrees(drop.angle))
                    .offset(drop.offset)
            }
            .opacity(mood == .failed ? 1 : 0)
        }
        .frame(width: Constants.size.width, height: Constants.size.height)
    }
}

private extension Constants {
    static let size: CGSize = .init(width: 60, height: 74)
    static let darkFurColor: Color = .init(red: 0.38, green: 0.24, blue: 0.14)
    static let bodyColors: [Color] = [.init(red: 0.5, green: 0.33, blue: 0.2), .init(red: 0.4, green: 0.26, blue: 0.15)]
    static let headColors: [Color] = [.init(red: 0.58, green: 0.4, blue: 0.25), .init(red: 0.5, green: 0.33, blue: 0.2)]
    static let innerEarColor: Color = .init(red: 0.72, green: 0.53, blue: 0.38)
    static let bellyColor: Color = .init(red: 0.82, green: 0.68, blue: 0.52)
    static let muzzleColor: Color = .init(red: 0.95, green: 0.88, blue: 0.76)
    static let noseColor: Color = .init(red: 0.2, green: 0.12, blue: 0.08)
    static let waterColor: Color = .init(red: 0.38, green: 0.65, blue: 0.92).opacity(0.75)
    static let dropColor: Color = .init(red: 0.35, green: 0.62, blue: 0.95)
    static let earSize: CGFloat = 11
    static let innerEarSize: CGFloat = 5
    static let mirrors: [CGFloat] = [-1, 1]
    static let earX: CGFloat = 21
    static let earY: CGFloat = -25
    static let headSize: CGSize = .init(width: 52, height: 42)
    static let headY: CGFloat = -14
    static let bodySize: CGSize = .init(width: 44, height: 42)
    static let bodyY: CGFloat = 16
    static let bellySize: CGSize = .init(width: 28, height: 26)
    static let bellyY: CGFloat = 21
    static let muzzleY: CGFloat = -1
    static let eyesY: CGFloat = -21
    static let shellY: CGFloat = 20
    static let pawsY: CGFloat = 12
    static let waterSize: CGSize = .init(width: 56, height: 10)
    static let waterY: CGFloat = 32
    static let shakeTilt: Double = -10
    static let shakeShift: CGFloat = 3
    static let dropSize: CGSize = .init(width: 3, height: 5)
    static let drops: [WaterDrop] = [
        .init(offset: .init(width: -22, height: -36), angle: -35),
        .init(offset: .init(width: 4, height: -38), angle: 0),
        .init(offset: .init(width: 25, height: -30), angle: 35),
        .init(offset: .init(width: 28, height: -16), angle: 65)
    ]
}
