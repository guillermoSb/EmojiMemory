//
//  MemoryGame.swift
//  EmojiMemory
//
//  Created by Guillermo Santos Barrios on 1/19/22.
//

import Foundation


struct MemoryGame<CardContent> {
    
    let cards: [MemoryCard]
    let score: Int = 0
    
    static func createMemoryGame(library: [CardContent]) -> MemoryGame<CardContent> {
        return MemoryGame<CardContent>(cards: library.map({ emoji in
            MemoryGame<CardContent>.MemoryCard(value: emoji, isFaceUp: false)
        }))
    }
    
    struct MemoryCard {
        let value: CardContent
        var isFaceUp: Bool
    }
}

