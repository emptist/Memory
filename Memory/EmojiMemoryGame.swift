//
//  EmojiMemoryGame.swift
//  Memory
//
//  Created by jk on 2020/6/3.
//  Copyright © 2020 ssl. All rights reserved.
//

import SwiftUI

class EmojiMemoryGame {
	
	private var game: MemoryGame<String> = EmojiMemoryGame.createCards()
	
	static func createCards() -> MemoryGame<String> {
		let emojis = ["🐵","🍎","🌮"]
		return MemoryGame<String>(numberPairsOfCards:emojis.count, cardFactor: {pairIndex in
			emojis[pairIndex]
		})
	}
	
	// MARK: - access to model

	var cards: Array<MemoryGame<String>.Card> {
		game.cards
	}
	
	// MARK: - intent(s)
	
	func choose(card:MemoryGame<String>.Card) -> Void {
		game.choose(card: card)
	}
}
