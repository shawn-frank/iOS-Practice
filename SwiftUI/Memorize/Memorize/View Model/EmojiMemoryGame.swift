//
//  EmojiMemoryGame.swift
//  Memorize
//
//  Created by Shawn Frank on 14/2/2023.
//

import Foundation

class EmojiMemoryGame: ObservableObject {
    static let emojis = ["🚔", "🚤", "🛵", "🚚", "✈️", "🚌", "🚁", "🛸", "🏎", "🚀", "🚊", "⛵️", "🛰", "🛴", "🚢", "⛱", "🏰", "🗼"]
    
    static func createMemoryGame() -> MemoryGame<String> {
        MemoryGame<String>(numberOfPairs: 3) { pairIndex in
            return emojis[pairIndex]
        }
    }
    
    @Published private var model = createMemoryGame()
    
    var cards: Array<MemoryGame<String>.Card> {
        model.cards
    }
    
    // MARK: Intents
    
    func choose(_ card: MemoryGame<String>.Card) {
        model.choose(card)
    }
}
