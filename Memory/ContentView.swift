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
        
        VStack {
            Grid(items: emojiGame.cards) { card in
                CardView(card: card)
                    .padding(5)
                    .onTapGesture {
                        withAnimation(.easeInOut(duration:1)) {
                            self.emojiGame.choose(card: card)
                        }
                        
                }
            }
            .padding()
            .foregroundColor(Color.orange)
            
            Button(
                action: {
                    withAnimation(.easeInOut(duration:1)) {
                        self.emojiGame.reset()
                    }
                },
                label: {
                    Text("New Game")// String in red color suggests localization needed
                }
            )
        }
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
	
    @State private var animatedBonusRemaining:Double = 0
    private func startBonusTimeAnimation() {
        animatedBonusRemaining = card.bonusRemaining
        withAnimation(.linear(duration:card.bonusTimeRemaining)) {
            animatedBonusRemaining = 0
        }
    }
    
    @ViewBuilder
    private func viewBody(for size: CGSize) -> some View {
        if card.isFaceUp || !card.isMatched {
            ZStack {
                Group {
                    if card.isConsumingBonusTime {
                        Pie(startAngle: Angle(degrees: -90), endAngle: Angle(degrees: -animatedBonusRemaining*360 - 90))
                            .onAppear {
                                self.startBonusTimeAnimation()
                        }
                    } else {
                        Pie(startAngle: Angle(degrees: -90), endAngle: Angle(degrees:
                            -card.bonusRemaining*360 - 90))
                    }
                    
                }
                .padding(5).opacity(0.2)
                .transition(.scale)
                
                
                Text(card.content)
                    .font(.system(size: k*min(size.width,size.height)))
                    .rotationEffect(Angle.degrees(card.isMatched ? 360 : 0))
                    .animation(card.isMatched ? Animation.easeInOut(duration: 1).repeatForever(autoreverses: false) : .default)
            }
            .cardify(isFaceUp: card.isFaceUp)
            .transition(AnyTransition.scale)
            
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

