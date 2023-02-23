//
//  MemoryGame.swift
//  Memorize
//
//  Created by Shawn Frank on 14/2/2023.
//

import Foundation

struct MemoryGame<CardContent> where CardContent: Equatable {
    private(set) var cards: Array<Card>
    
    private var indexOfFirstFaceUpCard: Int?
    
    mutating func choose(_ card: Card) {
        if let chosenIndex = cards.firstIndex(where: { $0.id == card.id }),
            !cards[chosenIndex].isFaceUp,
            !cards[chosenIndex].isMatched {
            
            if let faceUpCardIndex = indexOfFirstFaceUpCard {
                if cards[chosenIndex].content == cards[faceUpCardIndex].content {
                    cards[chosenIndex].isMatched = true
                    cards[faceUpCardIndex].isMatched = true
                }
                
                indexOfFirstFaceUpCard = nil
            }
            else {
                for cardIndex in cards.indices {
                    cards[cardIndex].isFaceUp = false
                }
                
                indexOfFirstFaceUpCard = chosenIndex
            }
            
            cards[chosenIndex].isFaceUp.toggle()
        }
    }
    
    init(numberOfPairs: Int, createCardContent: (Int) -> CardContent) {
        cards = Array<Card>()
        
        // add number of Pairs of cards x 2 into the array
        
        for pairIndex in 0..<numberOfPairs {
            let content = createCardContent(pairIndex)
            cards.append(Card(content: content, id: pairIndex*2))
            cards.append(Card(content: content, id: pairIndex*2+1))
        }
    }
    
    struct Card: Identifiable {
        var isFaceUp = false
        var isMatched = false
        var content: CardContent
        var id: Int
    }
}
