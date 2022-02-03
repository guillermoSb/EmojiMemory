//
//  EmojiGameVC.swift
//  EmojiMemory
//
//  Created by Guillermo Santos Barrios on 1/19/22.
//

import UIKit

class MemoryGameVC: UIViewController {
    
    @IBOutlet var collectionView: UICollectionView!
    
    @IBOutlet var scoreNavigationItem: UINavigationItem!
    private let presenter: MemoryGameP = MemoryGameP()
    
    var itemsPerRow: CGFloat = 4
    var spacingBetweenCells: CGFloat = 10
    private var score: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.setViewDelegate(delegate: self)
        
        //Configure the collectionView
        configureCollectionView()
        // Get the initial memory game
        presenter.getMemoryGame()
        showScore()
    }

    func configureCollectionView() {
        collectionView.isScrollEnabled = false
    }
    
    func showScore() {
        scoreNavigationItem.title = "Score: \(score)"
    }
    
    @IBAction func restartButtonTapped(_ sender: UIBarButtonItem) {
        self.collectionView.performBatchUpdates {
            self.collectionView.deleteItems(at: collectionView.indexPathsForVisibleItems)
            presenter.restartGame()
            self.score = 0
            showScore()
        }

   
    }
    
    private let collectionViewInsets: UIEdgeInsets = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
}

func calculateLayout(for size: CGSize, itemCount: Int) -> (rows: Int, cols: Int) {
    let desiredAspectRatio: Double = 1  // An aspect ratio of 1:1 is always preferred
    let containerAspectRatio = abs(size.width/size.height)  // Get the container aspect ratio
    var smallestVariance: Double?
    var bestLayout: (rows: Int, cols: Int) = (rows:1,cols:1)
    for rows in 1...itemCount {
        let cols = (itemCount / rows) + (itemCount % rows > 0 ? 1 : 0)  // Get the number of columns for each layout
        // Only calculate necessary layouts
        if((rows - 1) * cols < itemCount) {
            let itemAspectRatio = containerAspectRatio * (Double(rows)/Double(cols))    // Get the aspect ratio of the item
            let variance = abs(itemAspectRatio - desiredAspectRatio)
            if smallestVariance == nil || variance < smallestVariance! {
                smallestVariance = variance
                bestLayout = (rows, cols)
            }
        }
    }
    return bestLayout
}

extension MemoryGameVC: MemoryGamePDelegate {
    
    func hideCard(at index: Int) {
        guard let indexPath = collectionView.indexPathsForVisibleItems.first(where: {$0.row == index}) else {return}
        let cardView = collectionView.cellForItem(at: indexPath) as! CardView
        if !cardView.cardHidden {
            cardView.hideCard()
        }
        
    }
    
    func markCardMathced(at index: Int) {
        guard let indexPath = collectionView.indexPathsForVisibleItems.first(where: {$0.row == index}) else {return}
        let cardView = collectionView.cellForItem(at: indexPath) as! CardView
        cardView.matchCard()
    }
    
    
    func flipCard(at index: Int) {
        // Find the card to flip
        guard let indexPath = collectionView.indexPathsForVisibleItems.first(where: {$0.row == index}) else {return}
        let cardView = collectionView.cellForItem(at: indexPath) as! CardView
        // Only flip the card if the state changes
        if cardView.isFaceUp != presenter.cards[index].isFaceUp {
            cardView.animationPercentageLeft = presenter.cards[index].bonusRemaining
            cardView.flipCard()
        }
        score = presenter.score
        showScore()
        
    }
    
    func presentCards(cards: [MemoryGame<String>.MemoryCard]) {
        collectionView.deleteItems(at: collectionView.indexPathsForVisibleItems)

        collectionView.reloadData()
    }
}


extension MemoryGameVC: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return presenter.cardCount
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let _ = collectionView.cellForItem(at: indexPath) as? CardView else {return}
        presenter.flipCard(at: indexPath.row)   // Change the state of the game
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return collectionViewInsets.bottom
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return collectionViewInsets
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cardView", for: indexPath) as! CardView
        cell.configureInitialState()
        cell.cardContent = presenter.cards[indexPath.row].value
        cell.animationDuration = presenter.bonusDuration
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let containerWidth =  collectionView.frame.width - (collectionViewInsets.left * 2)
        let containerHeight = collectionView.frame.height - (collectionViewInsets.bottom * 2)
        let (rows, cols) = calculateLayout(for: CGSize(width: containerWidth, height: containerHeight), itemCount: presenter.cardCount)
        
        let horizontalPadding: CGFloat = CGFloat(cols) * (collectionViewInsets.left)
        let widthPerItem = (containerWidth - horizontalPadding) / CGFloat(cols)
        
        let verticalPadding: CGFloat = CGFloat(rows) * (collectionViewInsets.bottom)
        let heightPerItem = (containerHeight - verticalPadding) / CGFloat(rows)
        return CGSize(width: widthPerItem, height: heightPerItem)
    }
}
