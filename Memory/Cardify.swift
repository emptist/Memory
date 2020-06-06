//
//  Cardify.swift
//  Memory
//
//  Created by jk on 2020/6/7.
//  Copyright © 2020 ssl. All rights reserved.
//

import SwiftUI

struct Cardify: ViewModifier {
    var isFaceUp: Bool
    func body(content: Content) -> some View {
        ZStack {
            if isFaceUp {
                RoundedRectangle(cornerRadius: radius).fill(Color.white)
                RoundedRectangle(cornerRadius: radius).stroke(lineWidth: linewidth)

                content
            } else {
                RoundedRectangle(cornerRadius: radius).fill()
            }
        }
    }
    private let radius: CGFloat = 10.0
    private let linewidth: CGFloat = 3
}


extension View {
    func cardify(isFaceUp: Bool) -> some View {
        modifier(Cardify(isFaceUp: isFaceUp))
    }
}
