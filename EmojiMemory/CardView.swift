//
//  CardView.swift
//  EmojiMemory
//
//  Created by Guillermo Santos Barrios on 1/20/22.
//

import UIKit

class CardView: UIView {

    // Outlets
    @IBOutlet var contentView: UIView!  // Card Content View
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
        contentView.frame = bounds
        addSubview(contentView)
        configureCardView()
    }
    
    // Configure the card view
    func configureCardView() {
        contentView.layer.borderColor = cardColor.cgColor
        contentView.layer.cornerRadius = 10
        contentView.layer.cornerCurve = .continuous
        contentView.layer.borderWidth = 2
        switchCardState()   // Switch the card state
    }
    
    // Face up configuration
    func configureFaceUpCard() {
        emojiLabel.isHidden = false
        contentView.backgroundColor = .none
    }
    
    // Face down configuration
    func configureFaceDownCard() {
        emojiLabel.isHidden = true
        contentView.backgroundColor = .systemOrange
    }
    
    // Switch the card appearence
    func switchCardState() {
        if isFaceUp {
            configureFaceUpCard()
        } else {
            configureFaceDownCard()
        }
    }
    
    // Check for the user tapping on the card
    @IBAction func cardTapped(_ sender: UITapGestureRecognizer) {
        UIView.transition(with: contentView, duration: 0.30, options: [.transitionFlipFromLeft, .showHideTransitionViews]) {
            self.isFaceUp.toggle()
        }

    }
    

}
