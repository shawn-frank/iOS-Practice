//
//  EmojiMemoryGameView.swift
//  Memorize
//
//  Created by Shawn Frank on 13/2/2023.
//

import SwiftUI

struct EmojiMemoryGameView: View {
    @ObservedObject var game: EmojiMemoryGame
    
    @State private var dealt = Set<Int>()
    
    var body: some View {
        VStack {
            gameBody
            shuffleButton
        }
        .padding()
    }
    
    var gameBody: some View {
        AspectVGrid(items: game.cards, aspectRatio: 2/3) { card in
            if isUndealt(card) || (card.isMatched && !card.isFaceUp) {
                Color.clear
            }
            else {
                CardView(card: card)
                    .padding(4)
                    .transition(AnyTransition.asymmetric(insertion: .scale, removal: .opacity))
                    .onTapGesture {
                        withAnimation {
                            game.choose(card)
                        }
                    }
            }
            
        }
        .onAppear {
            for card in game.cards {
                deal(card)
            }
        }
        .foregroundColor(.red)
    }
    
    var shuffleButton: some View {
        Button("Shuffle") {
            withAnimation {
                game.suffle()
            }
        }
    }
    
    private func deal(_ card: EmojiMemoryGame.Card) {
        dealt.insert(card.id)
    }
    
    private func isUndealt(_ card: EmojiMemoryGame.Card) -> Bool {
        !dealt.contains(card.id)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        let game = EmojiMemoryGame()
        game.choose(game.cards.first!)
        
        return ZStack {
            EmojiMemoryGameView(game: game)
        }
        .previewDevice("iPhone 12 mini")
        .previewInterfaceOrientation(.portraitUpsideDown)
    }
}
