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
    private var memoryGame: MemoryGame<String>
    
    var cardCount: Int {memoryGame.cards.count}
    var cards: [MemoryGame<String>.MemoryCard] {memoryGame.cards}
    var score: Int {memoryGame.score}
    
    var bonusDuration: Double {memoryGame.bonusTime}
    
    init(memoryGame: MemoryGame<String>) {
        self.memoryGame = memoryGame
    }
    
    public func flipCard(at index: Int) {
        hideMatchedCards()
        // Flip a card on the model
        memoryGame.flipCard(at: index)
        // Flip the cards that are face up
        delegate?.flipCard(at: index)
        // Flip the cards as face down
        for (index, card) in cards.enumerated() {
            if !card.isFaceUp && !card.isMatched {
                delegate?.flipCard(at: index)
            }
            if card.isMatched {
                delegate?.markCardMathced(at: index)
            }
        }
        if memoryGame.gameIsEnded {
            print("GAME OVER!")
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
        self.memoryGame =  MemoryGame<String>.createMemoryGame(using:  ["👻", "😡", "👿","🤡","🎃", "🏓"], bonus: 3)
        
        self.getMemoryGame()
    }
    
    
    
}

protocol MemoryGamePDelegate {
    func presentCards(cards: [MemoryGame<String>.MemoryCard])
    func flipCard(at index: Int)
    func hideCard(at index: Int)
    func markCardMathced(at index: Int)
}
