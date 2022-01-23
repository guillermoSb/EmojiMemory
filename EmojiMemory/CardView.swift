//
//  CardView.swift
//  EmojiMemory
//
//  Created by Guillermo Santos Barrios on 1/20/22.
//

import UIKit

class CardView: UICollectionViewCell {

    // Outlets
    @IBOutlet var content: UIView!  // Card Content View
    @IBOutlet var emojiLabel: UILabel!  // Label with the emoji on it
    
    // Properties
    var cardColor: UIColor = .systemOrange  // Color for the card
    var cardContent: String {
        get {
            return emojiLabel.text ?? ""
        }
        set {
            emojiLabel.text = newValue
        }
    }
    // Wether the card is face up or face down
    var isFaceUp: Bool = false {
        didSet {
            switchCardState()
        }
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        initSubViews()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        initSubViews()
    }
    
    // Load nib file and create subView
    func initSubViews() {
        let nib = UINib(nibName: "CardView", bundle: nil)
        nib.instantiate(withOwner: self, options: nil)
        content.frame = bounds
        addSubview(content)
        configureCardView()
    }
    
    // Configure the card view
    func configureCardView() {
        content.layer.borderColor = cardColor.cgColor
        content.layer.cornerRadius = 10
        content.layer.cornerCurve = .continuous
        content.layer.borderWidth = 2
        switchCardState()   // Switch the card state
    }
    
    // Face up configuration
    func configureFaceUpCard() {
        emojiLabel.isHidden = false
        content.backgroundColor = .none
    }
    
    // Face down configuration
    func configureFaceDownCard() {
        emojiLabel.isHidden = true
        content.backgroundColor = .systemOrange
    }
    
    // Switch the card appearence
    func switchCardState() {
        if isFaceUp {
            configureFaceUpCard()
        } else {
            configureFaceDownCard()
        }
    }
    
    // Flip the card
    func flipCard() {
        UIView.transition(with: content, duration: 0.30, options: [.transitionFlipFromLeft, .showHideTransitionViews]) {
            self.isFaceUp.toggle()
        }

    }
    

}
