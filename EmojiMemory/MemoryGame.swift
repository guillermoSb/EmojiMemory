//
//  MemoryGame.swift
//  EmojiMemory
//
//  Created by Guillermo Santos Barrios on 1/19/22.
//

import Foundation


struct MemoryGame<CardContent> {
    
    struct MemoryCard {
        let value: CardContent
        var isFaceUp: Bool
    }
}
