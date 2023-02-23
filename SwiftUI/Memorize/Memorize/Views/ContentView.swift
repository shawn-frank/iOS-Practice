//
//  ContentView.swift
//  Memorize
//
//  Created by Shawn Frank on 13/2/2023.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject var game: EmojiMemoryGame
    
    var body: some View {
        ScrollView {
            LazyVGrid(columns: [GridItem(.adaptive(minimum: 65))]) {
                ForEach(game.cards) { card in
                    CardView(card: card)
                        .aspectRatio(2/3, contentMode: .fit)
                        .onTapGesture {
                            game.choose(card)
                        }
                }
            }
        }
        .padding(.horizontal)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        let game = EmojiMemoryGame()
        
        ZStack {
            ContentView(game: game)
        }
        .previewDevice("iPhone 12 mini")
        .previewInterfaceOrientation(.portraitUpsideDown)
    }
}
