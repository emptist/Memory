//
//  ContentView.swift
//  Memory
//
//  Created by jk on 2020/6/3.
//  Copyright © 2020 ssl. All rights reserved.
//

import SwiftUI

struct ContentView: View {
	var emojiGame: EmojiMemoryGame
	
	var body: some View {
			HStack {
				ForEach(emojiGame.cards, content: { card in
					CardView(isFaceUp: card.isFaceUp,cardViewContent:card.cardContent)
						.onTapGesture {
							self.emojiGame.choose(card: card)
					}
				})
		}
		.font(.largeTitle)
		.padding()
		.foregroundColor(Color.orange)
	}
}

struct CardView: View {
	var isFaceUp:Bool
	var cardViewContent: String
	
	var body: some View {
		ZStack {
			if isFaceUp {
			RoundedRectangle(cornerRadius: 10.0).fill(Color.white)
			RoundedRectangle(cornerRadius: 10.0).stroke()
			
			Text(cardViewContent)
				
			} else {
			RoundedRectangle(cornerRadius: 10.0).fill()
			}
		}
	}
}




struct ContentView_Previews: PreviewProvider {
	static var previews: some View {
		ContentView(emojiGame: EmojiMemoryGame())
	}
}

