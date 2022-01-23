//
//  EmojiGameP.swift
//  EmojiMemory
//
//  Created by Guillermo Santos Barrios on 1/21/22.
//

import UIKit


typealias PresenterDelegate = MemoryGamePDelegate & UIViewController

class MemoryGameP {
    
    weak var delegate: PresenterDelegate?
    private let memoryGame: MemoryGame = MemoryGame<String>.createMemoryGame(library:  ["👻", "😡", "👿","🤡","🎃", "🏓", "👿","🤡","🎃", "🏓", "🏓", "🏓", "🏓", "🏓", "🏓", "🏓", "🏓", "🏓", "🏓", "🏓", "🏓", "🏓", "🏓", "🏓", "🏓", "🏓", "🏓", "🏓", "🏓", "🏓", "🏓", "🏓", "🏓", "🏓", "🏓", "🏓"])
    
    var cardCount: Int {memoryGame.cards.count}
    var cards: [MemoryGame<String>.MemoryCard] {memoryGame.cards}
    
    public func setViewDelegate(delegate: PresenterDelegate) {
        self.delegate = delegate
    }
    
    public func getMemoryGame() {
        self.delegate?.presentCards(cards: memoryGame.cards)
    }
    
    
}

protocol MemoryGamePDelegate {
    func presentCards(cards: [MemoryGame<String>.MemoryCard])
}
