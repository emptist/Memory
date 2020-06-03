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
			HStack {
				ForEach(emojiGame.cards, content: { card in
					CardView(card: card)
						.onTapGesture {
							self.emojiGame.choose(card: card)
					}
				})
		}
		.padding()
		.foregroundColor(Color.orange)
	}
}

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
				RoundedRectangle(cornerRadius: 10.0).fill(Color.white)
				RoundedRectangle(cornerRadius: 10.0).stroke()
				
				Text(card.cardContent)
				
			} else {
				RoundedRectangle(cornerRadius: 10.0).fill()
			}
		}
		.font(.system(size: min(size.width,size.height)))
		
	}
}




struct ContentView_Previews: PreviewProvider {
	static var previews: some View {
		ContentView(emojiGame: EmojiMemoryGame())
	}
}

