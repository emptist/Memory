//
//  ContentView.swift
//  Memory
//
//  Created by jk on 2020/6/3.
//  Copyright © 2020 ssl. All rights reserved.
//

import SwiftUI

struct ContentView: View {
	@ObservedObject var emojiGame: EmojiMemoryGame
	
	var body: some View {
		
        Grid(items: emojiGame.cards, viewForItem: { card in
            CardView(card: card)
                .padding(0.5)
                .onTapGesture {
                    self.emojiGame.choose(card: card)
            }
        })
        .padding()
        .foregroundColor(Color.orange)
	}
}




/// Sub-view for a card, type being Model's Card
struct CardView: View {
	var card: MemoryGame<String>.Card
	
	var body: some View {
		GeometryReader(content: { geometry in
			self.viewBody(for: geometry.size)
		})
	}
	
	func viewBody(for size: CGSize) -> some View {
		ZStack {
			if card.isFaceUp {
				RoundedRectangle(cornerRadius: radius).fill(Color.white)
				RoundedRectangle(cornerRadius: radius).stroke()
				
				Text(card.content)
				
			} else {
                if !card.isMatched {
                    RoundedRectangle(cornerRadius: radius).fill()
                }
				
			}
		}
		.font(.system(size: k*min(size.width,size.height)))
	}
	
	let radius:CGFloat = 10.0
	let k:CGFloat = 0.75
}




struct ContentView_Previews: PreviewProvider {
	static var previews: some View {
		ContentView(emojiGame: EmojiMemoryGame())
	}
}

