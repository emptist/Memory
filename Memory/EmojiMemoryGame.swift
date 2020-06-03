//
//  EmojiMemoryGame.swift
//  Memory
//
//  Created by jk on 2020/6/3.
//  Copyright © 2020 ssl. All rights reserved.
//

import SwiftUI

/// View model of the game as a class, since it could be shared among views and also since only classes can conform to ObservableObject protocal
class EmojiMemoryGame: ObservableObject {
	
	/// Game model, with @Published property wrapper to catch any mutating on it
	@Published private var game: MemoryGame<String> = EmojiMemoryGame.createCards()
	
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
	
	
	/// Ask model to choose when user tapped a card, and will cause mutating on the model
	/// - Parameter card: that user tapped on
	/// - Returns: Void
	func choose(card:MemoryGame<String>.Card) -> Void {
		game.choose(card: card)
	}
}
