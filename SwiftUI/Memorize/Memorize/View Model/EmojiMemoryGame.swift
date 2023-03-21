//
//  EmojiMemoryGame.swift
//  Memorize
//
//  Created by Shawn Frank on 14/2/2023.
//

import Foundation

class EmojiMemoryGame: ObservableObject {
    typealias Card = MemoryGame<String>.Card
    
    private static let emojis = ["🚔", "🚤", "🛵", "🚚", "✈️", "🚌", "🚁", "🛸", "🏎", "🚀", "🚊", "⛵️", "🛰", "🛴", "🚢", "⛱", "🏰", "🗼"]
    
    private static func createMemoryGame() -> MemoryGame<String> {
        MemoryGame<String>(numberOfPairs: 3) { pairIndex in
            return emojis[pairIndex]
        }
    }
    
    @Published private var model = createMemoryGame()
    
    var cards: Array<Card> {
        model.cards
    }
    
    // MARK: Intents
    
    func choose(_ card: Card) {
        model.choose(card)
    }
}
