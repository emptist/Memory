//
//  MemoryGame.swift
//  Memory
//
//  Created by jk on 2020/6/3.
//  Copyright © 2020 ssl. All rights reserved.
//

import Foundation

struct MemoryGame<CardContent> {
	var cards:Array<Card>
	
	
	/// Mutating self by change the isFaceUp property of chosen card
	/// - Parameter card: is player selected card
	/// - Returns: index of the `card` or nil
	mutating func choose(card:Card) -> Void {
		print("card chosen: \(card)")

        let idx = cards.firstIndex(matching: card)
		cards[idx].isFaceUp.toggle()
	}
	
	init(numberPairsOfCards:Int,cardFactor: (Int)-> CardContent) {
		cards = Array<Card>()
		
		for pairIndex in 0..<numberPairsOfCards {
			let content = cardFactor(pairIndex)
			cards.append(Card(cardContent: content, id: pairIndex*2))
			cards.append(Card(cardContent: content, id: pairIndex*2+1))
		}
	}
	
	struct Card: Identifiable {
		var isFaceUp: Bool = true
		var isMatch: Bool = false
		var cardContent: CardContent
		var id: Int
	}
	
}
