//
//  ContentView.swift
//  Memory
//
//  Created by jk on 2020/6/3.
//  Copyright © 2020 ssl. All rights reserved.
//

import SwiftUI


struct ContentView: View {
    var body: some View {
        GameView(emojiGame:EmojiMemoryGame())
    }
}



struct GameView: View {
    @ObservedObject var emojiGame: EmojiMemoryGame
    
    var body: some View {
        
        Grid(items: emojiGame.cards) { card in
            CardView(card: card)
                .padding(5)
                .onTapGesture {
                    self.emojiGame.choose(card: card)
            }
        }
        .padding()
        .foregroundColor(Color.orange)
    }
}



/// Sub-view for a card, type being Model's Card
struct CardView: View {
	var card: MemoryGame<String>.Card
	
	var body: some View {
        GeometryReader { geometry in
			self.viewBody(for: geometry.size)
        }
	}
	
    @ViewBuilder
    private func viewBody(for size: CGSize) -> some View {
        if card.isFaceUp || !card.isMatched {
            ZStack {
                Pie(startAngle: Angle(degrees: 270), endAngle: Angle(degrees: 30))
                    .padding(5).opacity(0.2)
                Text(card.content)
                
            }
            .cardify(isFaceUp: card.isFaceUp)
            .font(.system(size: k*min(size.width,size.height)))
        }
	}
	
	//private let radius:CGFloat = 10.0
    private let k:CGFloat = 0.75
    
}




struct ContentView_Previews: PreviewProvider {
	static var previews: some View {
        let game = EmojiMemoryGame()
        game.choose(card: game.cards.last!)
		return GameView(emojiGame: game)
	}
}

