//
//  MemoryGame.swift
//  Memorize
//
//  Created by Shawn Frank on 14/2/2023.
//

import Foundation

struct MemoryGame<CardContent> where CardContent: Equatable {
    private(set) var cards: Array<Card>
    
    private var indexOfOneAndOnlyFaceUpCard: Int? {
        get { cards.indices.filter({ cards[$0].isFaceUp }).oneAndOnly }
        set { cards.indices.forEach { cards[$0].isFaceUp = ($0 == newValue) } }
    }
    
    mutating func choose(_ card: Card) {
        if let chosenIndex = cards.firstIndex(where: { $0.id == card.id }),
           !cards[chosenIndex].isFaceUp,
           !cards[chosenIndex].isMatched {
            
            if let potentialMatchIndex = indexOfOneAndOnlyFaceUpCard {
                if cards[chosenIndex].content == cards[potentialMatchIndex].content {
                    cards[chosenIndex].isMatched = true
                    cards[potentialMatchIndex].isMatched = true
                }
                
                cards[chosenIndex].isFaceUp = true
            }
            else {
                indexOfOneAndOnlyFaceUpCard = chosenIndex
            }
        }
    }
    
    mutating func shuffle() {
        cards.shuffle()
    }
    
    init(numberOfPairs: Int, createCardContent: (Int) -> CardContent) {
        cards = Array<Card>()
        
        // add numberOfPairs of cards x 2 into the array
        for pairIndex in 0..<numberOfPairs {
            let content = createCardContent(pairIndex)
            cards.append(Card(content: content, id: pairIndex*2))
            cards.append(Card(content: content, id: pairIndex*2+1))
        }
        
        cards.shuffle()
    }
    
    struct Card: Identifiable {
        var isFaceUp = false {
            didSet {
                if isFaceUp {
                    startUsingBonusTime()
                }
                else {
                    stopUsingBonusTime()
                }
            }
        }
        
        var isMatched = false {
            didSet {
                stopUsingBonusTime()
            }
        }
        var content: CardContent
        var id: Int
        
        // MARK: Bonus time
        
        // This could give matching bonus points
        // if the user matches the card
        // before a certain amount of time passes during which the card is face up
        
        // can be 0, which means no bonus time available for this card
        var bonusTimeLimit: TimeInterval = 6
        
        // how long this card has ever been face up
        private var faceUpTime: TimeInterval {
            if let lastFaceUpDate = self.lastFaceUpDate {
                return pastFaceUpTime + Date().timeIntervalSince(lastFaceUpDate)
            }
            
            return pastFaceUpTime
        }
        
        // The last time this card was turned face up (and is still face up)
        var lastFaceUpDate: Date?
        
        // the accumalated time this card has been face up in the past
        // (i.e not including the current time it's been face up if it is currently so)
        var pastFaceUpTime: TimeInterval = 0
        
        // how much time remaining before the bonus time runs out
        var bonusTimeRemaining: TimeInterval {
            max(0, bonusTimeLimit - faceUpTime)
        }
        
        // percentage of the bonus time remaining
        var bonusRemaining: Double {
            (bonusTimeLimit > 0 && bonusTimeRemaining > 0) ? bonusTimeRemaining / bonusTimeLimit : 0
        }
        
        // whether the card was matched during the bonus time period
        var hasEarnedBonus: Bool {
            isMatched && bonusTimeRemaining > 0
        }
        
        var isConsumingBonusTime: Bool {
            isFaceUp && !isMatched && bonusTimeRemaining > 0
        }
        
        // called when the card transitions to face up state
        private mutating func startUsingBonusTime() {
            if isConsumingBonusTime, lastFaceUpDate == nil {
                lastFaceUpDate = Date()
            }
        }
        
        // called when the card goes back face down (or gets matched)
        private mutating func stopUsingBonusTime() {
            pastFaceUpTime = faceUpTime
            self.lastFaceUpDate = nil
        }
    }
}
