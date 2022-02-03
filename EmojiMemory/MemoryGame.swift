//
//  MemoryGame.swift
//  EmojiMemory
//
//  Created by Guillermo Santos Barrios on 1/19/22.
//

import Foundation


struct MemoryGame<CardContent: Equatable> {
    
    private(set) var cards: [MemoryCard]
    private(set) var score: Int = 0
    
    private(set) var bonusTime: Double
    var gameIsEnded: Bool {
        for card in cards {
            if !card.isMatched {
                return false
            }
        }
        return true
    }
    
    private var currentFaceUpCard: Int?
    
    
    
    static func createMemoryGame(using library: [CardContent], bonus: Double) -> MemoryGame<CardContent> {
        
        var cards: [MemoryGame<CardContent>.MemoryCard] = []
        // library.shuffle()
        for content in library {
            // Create two cards for each item on the library
            cards.append(MemoryGame<CardContent>.MemoryCard(value: content, isFaceUp: false, bonusRemaining: 1, bonusDuration: bonus))
            cards.append(MemoryGame<CardContent>.MemoryCard(value: content, isFaceUp: false, bonusRemaining: 1, bonusDuration: bonus))
        }

        
        return MemoryGame<CardContent>(cards: cards.shuffled(), bonusTime: bonus)
    }
    
    
    mutating func flipCard(at index: Int) {
        if let currentFaceUpCard = currentFaceUpCard, index == currentFaceUpCard{
            return
        }
        
        if cards[index].isFaceUp || cards[index].isMatched {
            return
        }
        
        cards[index].isFaceUp = true
        cards[index].updateBonusTime()
        if let currentFaceUpCard = currentFaceUpCard {
            if cards[currentFaceUpCard].value == cards[index].value {
                cards[currentFaceUpCard].isMatched = true
                cards[index].isMatched = true
                score += 10
            }
            self.currentFaceUpCard = nil
        } else {
            currentFaceUpCard = index
            for (idx, card) in cards.enumerated() {
                if idx != currentFaceUpCard, card.isFaceUp {
                    cards[idx].isFaceUp = false
                    cards[idx].updateBonusTime()
                }
            }
        }
        
    }
    
    
    struct MemoryCard {
        let value: CardContent
        var isFaceUp: Bool = false
        var isMatched: Bool = false
        var bonusRemaining: Double
        var faceUpAt: Date?
        var faceDownAt: Date?
        var bonusDuration: Double
        
        private var hasBonus: Bool {
            return bonusRemaining > 0
        }

        private var animationPercentage: Double {
            guard let faceDownAt = faceDownAt,
                  let faceUpAt = faceUpAt else {
                      return 0  // No progress at all
                  }
            return min((faceUpAt.timeIntervalSinceReferenceDate - faceDownAt.timeIntervalSinceReferenceDate).magnitude / Double(bonusDuration), 1.0)
        }
        
        mutating func updateBonusTime() {
            if isFaceUp {
                faceUpAt = Date()
                faceDownAt = nil
            } else {
                faceDownAt = Date()
            }
            calculateBonusLeft()
            print("Bonus left is \(bonusRemaining)")
        }
        
        mutating func calculateBonusLeft() {
            bonusRemaining = max(bonusRemaining - animationPercentage, 0)
        }
        
        
    }
}

