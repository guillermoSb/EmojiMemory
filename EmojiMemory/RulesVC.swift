//
//  RulesVC.swift
//  EmojiMemory
//
//  Created by Guillermo Santos Barrios on 2/3/22.
//

import UIKit

class RulesVC: UIViewController {

    @IBOutlet var cardView: CardView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        cardView.emojiLabel.text = "🚀"
        cardView.animationDuration = 3
    }
    
    @IBAction func cardViewTapped(_ sender: UITapGestureRecognizer) {

        cardView.flipCard()
    }
    

}
