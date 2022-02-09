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
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "GameVC" {
            guard let sender = sender as? UITableViewCell else {return}
            guard let indexPath = tableView.indexPath(for: sender) else {return}
            let theme = themes[indexPath.row]
            guard let gameVC = segue.destination as? MemoryGameVC else {return}
            gameVC.presenter = MemoryGameP(memoryGame: MemoryGame.createMemoryGame(using: theme.content, bonus: 3))
            sender.isSelected = false
        }
    }
    

}

extension ThemeStoreVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return themes.count
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        true
    }
    
    func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let deleteAction = UIContextualAction(style: .destructive, title: "Delete") {(action, view, completion) in
            self.themes.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .automatic)

        }
        deleteAction.image = UIImage(systemName: "trash")
        let editAction = UIContextualAction(style: .normal, title: nil) {(action, view, completion) in
            let editThemeVC = EditThemeVC()
            self.present(editThemeVC, animated: true, completion: nil)
        }
        editAction.image = UIImage(systemName: "pencil")
        editAction.backgroundColor = .systemBlue
        return UISwipeActionsConfiguration(actions: [deleteAction, editAction])
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: TableViewCell.themeCell, for: indexPath)
        var contentConfiguration = cell.defaultContentConfiguration()
        contentConfiguration.text = themes[indexPath.row].title
        cell.contentConfiguration = contentConfiguration
        return cell
    }
    
    
}
