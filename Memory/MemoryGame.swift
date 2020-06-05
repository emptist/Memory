//
//  MemoryGame.swift
//  Memory
//
//  Created by jk on 2020/6/3.
//  Copyright © 2020 ssl. All rights reserved.
//

import Foundation

struct MemoryGame<CardContent> where CardContent: Equatable {
	var cards:Array<Card>
    var indexOfTheOnlyFaceUpCard: Optional<Int> {
        get {
            cards.indices.filter({cards[$0].isFaceUp}).onlyThingOrNil
        }
        set {
            for index in cards.indices {
                cards[index].isFaceUp = index == newValue
            }
        }
    }
	
	/// Mutating self by change the isFaceUp property of chosen card
	/// - Parameter card: is player selected card
	/// - Returns: index of the `card` or nil
	
    mutating func choose(card:Card) {
        print("card chosen: \(card)")

        guard let chosenIndex = cards.firstIndex(matching: card) else {return}
        
        if !cards[chosenIndex].isFaceUp && !cards[chosenIndex].isMatched {
            guard let otherIndex = indexOfTheOnlyFaceUpCard else {
                indexOfTheOnlyFaceUpCard = chosenIndex
                return
            }
            
            if cards[chosenIndex].content == cards[otherIndex].content {
                cards[chosenIndex].isMatched = true
                cards[otherIndex].isMatched = true
            }
            cards[chosenIndex].isFaceUp = true
        }
 	}
	
	init(numberPairsOfCards:Int,cardFactor: (Int)-> CardContent) {
		cards = Array<Card>()
		
		for pairIndex in 0..<numberPairsOfCards {
			let content = cardFactor(pairIndex)
			cards.append(Card(content: content, id: pairIndex*2))
			cards.append(Card(content: content, id: pairIndex*2+1))
		}
	}
	
	struct Card: Identifiable {
		var isFaceUp: Bool = false
		var isMatched: Bool = false
		var content: CardContent
		var id: Int
	}
	
}
