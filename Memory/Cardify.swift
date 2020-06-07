//
//  Cardify.swift
//  Memory
//
//  Created by jk on 2020/6/7.
//  Copyright © 2020 ssl. All rights reserved.
//

import SwiftUI

struct Cardify: AnimatableModifier {
    var rotation: Double
    init(isFaceUp:Bool) {
        rotation = isFaceUp ? 0 : 180
    }
    var isFaceUp: Bool {
        rotation < 90
    }
    var animatableData: Double {
        get {
            return rotation
        }
        set {
            rotation = newValue
        }
    }
    func body(content: Content) -> some View {
        ZStack {
            //if isFaceUp {
            Group {
                RoundedRectangle(cornerRadius: radius).fill(Color.white)
                RoundedRectangle(cornerRadius: radius).stroke(lineWidth: linewidth)

                content
            //} else {
            }
                .opacity(isFaceUp ? 1 : 0) // 0 全透明,故不呈現
            RoundedRectangle(cornerRadius: radius).fill()
                .opacity(isFaceUp ? 0 : 1)
            
        }
        .rotation3DEffect(Angle.degrees(rotation), axis: (0,1,0))
    }
    private let radius: CGFloat = 10.0
    private let linewidth: CGFloat = 3
}


extension View {
    func cardify(isFaceUp: Bool) -> some View {
        modifier(Cardify(isFaceUp: isFaceUp))
    }
}
