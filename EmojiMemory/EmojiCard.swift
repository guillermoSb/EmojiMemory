//
//  EmojiCardVC.swift
//  EmojiMemory
//
//  Created by Guillermo Santos Barrios on 1/19/22.
//

import UIKit

class EmojiCard: UIView {

    override init(frame: CGRect) {
        super.init(frame: frame)
        configureCard()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        configureCard()
    }
    
    func configureCard() {
        proin
        self.backgroundColor = .red
    }
}
