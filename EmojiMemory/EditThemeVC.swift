//
//  EditThemeVC.swift
//  EmojiMemory
//
//  Created by Guillermo Santos Barrios on 2/9/22.
//

import UIKit

class EditThemeVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        prepareView()
    }
    
    
    override func viewWillDisappear(_ animated: Bool) {
        // Save the theme
        super.viewWillDisappear(animated)
    }
    
    func prepareView() {
        view.backgroundColor = .white
        createTitleLabel()
    }
    
    func createTitleLabel() {
        let textLabel = UILabel()
        textLabel.translatesAutoresizingMaskIntoConstraints = false
        textLabel.text = "Edit Theme"
        textLabel.font = UIFont.preferredFont(forTextStyle: .title1)
        view.addSubview(textLabel)
        NSLayoutConstraint.activate([
            textLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            textLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 24)
        ])
    }
    
    func createThemeNameForm() {
        
    }
}
