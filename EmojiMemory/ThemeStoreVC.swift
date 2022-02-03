//
//  ThemeStoreVC.swift
//  EmojiMemory
//
//  Created by Guillermo Santos Barrios on 2/3/22.
//

import UIKit

class ThemeStoreVC: UIViewController {
    // Properties
    var themes: [MemoryGameTheme] = []
    // Outlets
    @IBOutlet var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
    }
    
    @IBAction func addThemeButtonTapped(_ sender: UIBarButtonItem) {
        themes.insert(MemoryGameTheme.defaultTheme, at: 0)
        tableView.insertRows(at: [IndexPath(row: 0, section: 0)], with: .left)
    }
    
    enum TableViewCell {
        static let themeCell = "themeCell"
    }
    

}

extension ThemeStoreVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return themes.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: TableViewCell.themeCell, for: indexPath)
        var contentConfiguration = cell.defaultContentConfiguration()
        contentConfiguration.text = themes[indexPath.row].title
        cell.contentConfiguration = contentConfiguration
        return cell
    }
    
    
}
