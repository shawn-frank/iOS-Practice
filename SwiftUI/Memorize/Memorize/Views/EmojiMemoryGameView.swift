//
//  EmojiMemoryGameView.swift
//  Memorize
//
//  Created by Shawn Frank on 13/2/2023.
//

import SwiftUI

struct EmojiMemoryGameView: View {
    @ObservedObject var game: EmojiMemoryGame
    
    var body: some View {
        
        AspectVGrid(items: game.cards, aspectRatio: 2/3) { card in
            CardView(card: card)
                .padding(4)
                .onTapGesture {
                    game.choose(card)
                }
        }
        .foregroundColor(.red)
        .padding(.horizontal)
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
