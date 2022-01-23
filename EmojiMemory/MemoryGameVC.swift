//
//  EmojiGameVC.swift
//  EmojiMemory
//
//  Created by Guillermo Santos Barrios on 1/19/22.
//

import UIKit

class MemoryGameVC: UIViewController {
    
    @IBOutlet var collectionView: UICollectionView!
    
    private let presenter: MemoryGameP = MemoryGameP()
    
    var itemsPerRow: CGFloat = 4
    var spacingBetweenCells: CGFloat = 10
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.setViewDelegate(delegate: self)
        
        //Configure the collectionView
        configureCollectionView()
        // Get the initial memory game
        presenter.getMemoryGame()
    }

    func configureCollectionView() {
        collectionView.isScrollEnabled = false
//        let bestLayout = calculateLayout(for: collectionView.frame.size)
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
    print("Best layout for \(itemCount)")
    print(bestLayout)
    return bestLayout
}

extension MemoryGameVC: MemoryGamePDelegate {
    func presentCards(cards: [MemoryGame<String>.MemoryCard]) {
        // TODO
    }
}


extension MemoryGameVC: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return presenter.cardCount
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let cardView = collectionView.cellForItem(at: indexPath) as? CardView else {return}
        cardView.flipCard()
        print("selected \(indexPath.row)")
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return collectionViewInsets.bottom
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return collectionViewInsets
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cardView", for: indexPath) as! CardView
        cell.cardContent = presenter.cards[indexPath.row].value
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