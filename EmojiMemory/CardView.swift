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
    var pieContainer: UIView = UIView()
    var pieLayer = PieShapeLayer()
    
    // Properties
    var cardColor: UIColor = .systemOrange  // Color for the card
    var cardHidden = false
    private var isMatched = false
    var cardContent: String {
        get {
            return emojiLabel.text ?? ""
        }
        set {
            emojiLabel.text = newValue
        }
    }
    
    var animationDuration: Double = 0
    var animationPercentageLeft
    : Double = 1
    
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
    private func initSubViews() {
        let nib = UINib(nibName: "CardView", bundle: nil)
        nib.instantiate(withOwner: self, options: nil)
        content.frame = bounds
        insetsLayoutMarginsFromSafeArea = false
        addSubview(content)
        configureCardView()
        configurePieContainer()
        
    }
    
    
    // Configure the card view
    private func configureCardView() {
        content.layer.borderColor = cardColor.cgColor
        content.layer.cornerRadius = 10
        content.layer.cornerCurve = .continuous
        content.layer.borderWidth = 2
        switchCardState()   // Switch the card state
    }
    
    // Configure the pieContainer
    private func configurePieContainer() {
        content.addSubview(pieContainer)
        pieContainer.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            pieContainer.centerXAnchor.constraint(equalTo: content.centerXAnchor),
            pieContainer.centerYAnchor.constraint(equalTo: content.centerYAnchor),
            pieContainer.widthAnchor.constraint(equalToConstant: 20),
            pieContainer.heightAnchor.constraint(equalToConstant: 20)
        ])
        content.sendSubviewToBack(pieContainer)
        createProgressCircle()
    }
    
    // Create the progress circle shape
    private func createProgressCircle() {
        self.pieLayer.strokeEnd = 1
        self.pieLayer.lineWidth = 10
        self.pieLayer.fillColor = UIColor.clear.cgColor
        self.pieLayer.strokeColor = UIColor.systemOrange.cgColor
        self.pieLayer.display()
        pieContainer.layer.addSublayer(self.pieLayer)
    }
    
    private func animatePie() {
        // Create the CA animation
        let animation = CABasicAnimation(keyPath: "strokeEnd")
        animation.fromValue = 1 - animationPercentageLeft
        animation.toValue = 1
        animation.duration = CFTimeInterval(animationDuration * animationPercentageLeft)
        animation.isRemovedOnCompletion = false
        animation.fillMode = .forwards
        pieLayer.add(animation, forKey: "strokeEnd")
    }
    
    
    // Face up configuration
    func configureFaceUpCard() {
        emojiLabel.isHidden = false
        pieContainer.isHidden = false
        content.backgroundColor = .none
        animatePie()
    }
    
    // Face down configuration
    func configureFaceDownCard() {
        emojiLabel.isHidden = true
        pieContainer.isHidden = true
        content.backgroundColor = .systemOrange
        pieLayer.removeAllAnimations()
    }
    
    
    // Switch the card appearence
    private func switchCardState() {
        if isFaceUp {
            configureFaceUpCard()
        } else {
            configureFaceDownCard()
        }
    }
    
    // Flip the card
    func flipCard() {
        UIView.transition(with: content, duration: 0.25, options: [.transitionFlipFromLeft, .showHideTransitionViews]) {
            self.isFaceUp.toggle()
        }
    }
    
    // Hide a Card
    func hideCard() {
        cardHidden = true
        let animator = UIViewPropertyAnimator(duration: 0.30, curve: .easeOut) {
            self.alpha = 0
        }
        // Hide the view when the animation finishes
        animator.addCompletion { position in
            if position == .end {
                self.isHidden = true
            }
        }
        animator.startAnimation()
    }
    
    func configureInitialState() {
        isFaceUp = false
        alpha = 1
        isHidden = false
        cardHidden = false
        self.pieLayer.opacity = 1
        animationPercentageLeft = 1
    }
    
    // Mark a card as matched
    func matchCard() {
        if !isMatched {
            let animator = UIViewPropertyAnimator(duration: 0.30, curve: .easeOut) {
                self.pieLayer.opacity = 0
            }
            animator.startAnimation()
        }
        
    }
    
}
