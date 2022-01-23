//
//  MemoryGame.swift
//  EmojiMemory
//
//  Created by Guillermo Santos Barrios on 1/19/22.
//

import Foundation


struct MemoryGame<CardContent: Equatable> {
    
    var cards: [MemoryCard]
    let score: Int = 0
    
    var currentFaceUpCard: Int?  // The current face up card
    
    static func createMemoryGame(library: [CardContent]) -> MemoryGame<CardContent> {
        
        var cards: [MemoryGame<CardContent>.MemoryCard] = []
        // library.shuffle()
        for content in library {
            // Create two cards for each item on the library
            cards.append(MemoryGame<CardContent>.MemoryCard(value: content, isFaceUp: false))
            cards.append(MemoryGame<CardContent>.MemoryCard(value: content, isFaceUp: false))
        }
        
        return MemoryGame<CardContent>(cards: cards)
    }
    
    
    mutating func flipCard(at index: Int) {
        if let currentFaceUpCard = currentFaceUpCard {
            // If the current card content is equal to the new card content set both as matched
            if cards[currentFaceUpCard].value == cards[index].value {
                cards[currentFaceUpCard].isMatched.toggle()
                cards[index].isMatched.toggle()
            }
            self.currentFaceUpCard = nil
        } else {
            allCardsFaceDown()
            currentFaceUpCard = index
        }
        cards[index].isFaceUp.toggle()
    }
    
    mutating func allCardsFaceDown() {
        for index in 0..<cards.count {
            if !cards[index].isMatched {
                cards[index].isFaceUp = false
            }
        }
    }
    
    struct MemoryCard {
        let value: CardContent
        var isFaceUp: Bool
        var isMatched: Bool = false
    }
}

