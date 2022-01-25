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
    private var memoryGame: MemoryGame = MemoryGame<String>.createMemoryGame(library:  ["👻", "😡", "👿","🤡","🎃", "🏓"])
    
    var cardCount: Int {memoryGame.cards.count}
    var cards: [MemoryGame<String>.MemoryCard] {memoryGame.cards}
    
    public func flipCard(at index: Int) {
        // Hide Matched Cards
        hideMatchedCards()
        guard !cards[index].isFaceUp else {return}
        memoryGame.flipCard(at: index)
        // Handle new flips
        for cardIndex in 0..<cards.count {
            delegate?.flipCard(at: cardIndex)
        }

    }
    
    public func hideMatchedCards() {
        for cardIndex in 0..<cards.count {
            if cards[cardIndex].isMatched {
                delegate?.hideCard(at: cardIndex)
            }
        }
    }
    
    public func setViewDelegate(delegate: PresenterDelegate) {
        self.delegate = delegate
    }
    
    public func getMemoryGame() {
        self.delegate?.presentCards(cards: memoryGame.cards)
    }
    
    public func restartGame() {
        self.memoryGame =  MemoryGame<String>.createMemoryGame(library:  ["👻", "😡", "👿","🤡","🎃", "🏓"])
        self.getMemoryGame()
    }
    
    
}

protocol MemoryGamePDelegate {
    func presentCards(cards: [MemoryGame<String>.MemoryCard])
    func flipCard(at index: Int)
    func hideCard(at index: Int)
}
