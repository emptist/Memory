//
//  MemoryGame.swift
//  Memory
//
//  Created by jk on 2020/6/3.
//  Copyright © 2020 ssl. All rights reserved.
//

import Foundation

struct MemoryGame<CardContent> where CardContent: Equatable {
	private(set) var cards: Array<Card>
    
    private var indexOfTheOnlyFaceUpCard: Optional<Int> {
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
        cards.shuffle()
	}
	
	struct Card: Identifiable {
        var isFaceUp: Bool = false {
            didSet {
                if isFaceUp {
                    startUsingBonusTime()
                } else {
                    stopUsingBonusTime()
                }
            }
        }
        var isMatched: Bool = false {
            didSet {
                stopUsingBonusTime()
            }
        }
		var content: CardContent
		var id: Int
	
    
    
        // MARK: - Bonus Time
        
        /// This could give matching bonus points
        /// if the user matches the card
        /// before a certain amount of time passes during which the card is face up
        
        /// can be 0 which means "no bonus time available for this card"
        var bonusTimeLimit: TimeInterval = 6
        
        /// how long this card has been face up
        private var faceUpTime: TimeInterval {
            if let lastFaceUpDate = self.lastFaceUpDate {
                return pastFaceUpTime + Date().timeIntervalSince(lastFaceUpDate)
            } else {
                return pastFaceUpTime
            }
        }
        
        // the last time this card has been turned and still is face up
        var lastFaceUpDate: Optional<Date> = .none
        
        var pastFaceUpTime: TimeInterval = 0
        
        var bonusTimeRemaining: TimeInterval {
            max(0, bonusTimeLimit - faceUpTime)
        }
        
        var bonusRemaining: Double {
            (bonusTimeLimit > 0 && bonusTimeRemaining > 0) ? bonusTimeRemaining/bonusTimeLimit : 0
        }
        
        var hasEarnedBonus: Bool {
            isMatched && bonusTimeRemaining > 0
        }
        
        var isConsumingBonusTime: Bool {
            isFaceUp && !isMatched && bonusTimeRemaining > 0
        }
        
        private mutating func startUsingBonusTime() {
            if isConsumingBonusTime, lastFaceUpDate == nil {
                lastFaceUpDate = Date()
            }
        }
        
        private mutating func stopUsingBonusTime() {
            pastFaceUpTime = faceUpTime
            self.lastFaceUpDate = nil
        }

    }
	
    
    
}
