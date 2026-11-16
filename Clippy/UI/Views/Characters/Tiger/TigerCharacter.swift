//
//  TigerCharacter.swift
//  Clippy
//
//  Created by Salomé Russier on 16/11/2026.
//

import SwiftUI

struct TigerCharacter: View {
    let mood: Mood

    var body: some View {
        ZStack {
            TigerTailView(isSwishing: mood == .working)
                .offset(x: Constants.tailX, y: Constants.tailY)
            ForEach(Constants.mirrors, id: \.self) { mirror in
                Circle()
                    .fill(Constants.darkFurColor)
                    .frame(width: Constants.earSize, height: Constants.earSize)
                    .overlay {
                        Circle()
                            .fill(Constants.whiteColor)
                            .frame(width: Constants.innerEarSize, height: Constants.innerEarSize)
                    }
                    .scaleEffect(y: mood == .failed ? Constants.droopedEarScale : 1)
                    .offset(
                        x: mirror * (mood == .failed ? Constants.droopedEarX : Constants.earX),
                        y: mood == .failed ? Constants.droopedEarY : Constants.earY
                    )
            }
            Ellipse()
                .fill(.linearGradient(colors: Constants.furColors, startPoint: .top, endPoint: .bottom))
                .frame(width: Constants.bodySize.width, height: Constants.bodySize.height)
                .offset(y: Constants.bodyY)
            Ellipse()
                .fill(Constants.whiteColor)
                .frame(width: Constants.bellySize.width, height: Constants.bellySize.height)
                .offset(y: Constants.bellyY)
            ForEach(Constants.mirrors, id: \.self) { mirror in
                ForEach(Constants.bodyStripes, id: \.self) { stripe in
                    Capsule()
                        .fill(Constants.stripeColor)
                        .frame(width: Constants.stripeSize.width, height: Constants.stripeSize.height)
                        .rotationEffect(.degrees(mirror * stripe.angle))
                        .offset(x: mirror * stripe.offset.width, y: stripe.offset.height)
                }
                Ellipse()
                    .fill(Constants.pawColor)
                    .frame(width: Constants.pawSize.width, height: Constants.pawSize.height)
                    .offset(x: mirror * Constants.pawX, y: Constants.pawY)
            }
            Ellipse()
                .fill(.linearGradient(colors: Constants.furColors, startPoint: .top, endPoint: .bottom))
                .frame(width: Constants.headSize.width, height: Constants.headSize.height)
                .offset(y: Constants.headY)
            Capsule()
                .fill(Constants.stripeColor)
                .frame(width: Constants.stripeSize.height, height: Constants.stripeSize.width)
                .rotationEffect(.degrees(Constants.foreheadStripeAngle))
                .offset(y: Constants.foreheadStripeY)
            ForEach(Constants.mirrors, id: \.self) { mirror in
                ForEach(Constants.cheekStripes, id: \.self) { stripe in
                    Capsule()
                        .fill(Constants.stripeColor)
                        .frame(width: Constants.stripeSize.height, height: Constants.stripeSize.width)
                        .rotationEffect(.degrees(mirror * stripe.angle))
                        .offset(x: mirror * stripe.offset.width, y: stripe.offset.height)
                }
            }
            MuzzleView(color: Constants.whiteColor, noseColor: Constants.noseColor)
                .offset(y: Constants.muzzleY)
            HappyEyeShape()
                .stroke(Constants.stripeColor, style: .init(lineWidth: Constants.smileWidth, lineCap: .round))
                .frame(width: Constants.smileSize.width, height: Constants.smileSize.height)
                .rotationEffect(.degrees(Constants.smileAngle))
                .offset(y: Constants.smileY)
                .opacity(mood == .finished ? 1 : 0)
            EyePairView(mood: mood)
                .offset(y: Constants.eyesY)
        }
        .frame(width: Constants.size.width, height: Constants.size.height)
    }
}

private extension Constants {
    static let size: CGSize = .init(width: 60, height: 72)
    static let mirrors: [CGFloat] = [-1, 1]
    static let furColors: [Color] = [.init(red: 0.99, green: 0.63, blue: 0.22), .init(red: 0.93, green: 0.52, blue: 0.14)]
    static let darkFurColor: Color = .init(red: 0.88, green: 0.46, blue: 0.12)
    static let pawColor: Color = .init(red: 0.95, green: 0.58, blue: 0.2)
    static let whiteColor: Color = .init(red: 0.99, green: 0.97, blue: 0.93)
    static let stripeColor: Color = .init(red: 0.22, green: 0.13, blue: 0.08)
    static let noseColor: Color = .init(red: 0.9, green: 0.45, blue: 0.45)
    static let tailX: CGFloat = 14
    static let tailY: CGFloat = 12
    static let earSize: CGFloat = 13
    static let innerEarSize: CGFloat = 6
    static let earX: CGFloat = 19
    static let earY: CGFloat = -31
    static let droopedEarX: CGFloat = 25
    static let droopedEarY: CGFloat = -22
    static let droopedEarScale: CGFloat = 0.7
    static let headSize: CGSize = .init(width: 54, height: 44)
    static let headY: CGFloat = -13
    static let bodySize: CGSize = .init(width: 44, height: 38)
    static let bodyY: CGFloat = 17
    static let bellySize: CGSize = .init(width: 26, height: 24)
    static let bellyY: CGFloat = 22
    static let stripeSize: CGSize = .init(width: 3, height: 9)
    static let bodyStripes: [TigerStripe] = [
        .init(offset: .init(width: 17, height: 14), angle: -25),
        .init(offset: .init(width: 18, height: 24), angle: -25)
    ]
    static let foreheadStripeAngle: Double = 90
    static let foreheadStripeY: CGFloat = -32
    static let cheekStripes: [TigerStripe] = [
        .init(offset: .init(width: 23, height: -18), angle: -12),
        .init(offset: .init(width: 23, height: -11), angle: 0),
        .init(offset: .init(width: 23, height: -4), angle: 12)
    ]
    static let pawSize: CGSize = .init(width: 13, height: 8)
    static let pawX: CGFloat = 10
    static let pawY: CGFloat = 33
    static let muzzleY: CGFloat = 0
    static let smileSize: CGSize = .init(width: 12, height: 5)
    static let smileWidth: CGFloat = 1.8
    static let smileAngle: Double = 180
    static let smileY: CGFloat = 9
    static let eyesY: CGFloat = -20
}
