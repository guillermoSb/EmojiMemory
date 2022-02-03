//
//  MemoryGameTheme.swift
//  EmojiMemory
//
//  Created by Guillermo Santos Barrios on 2/3/22.
//

import Foundation


struct MemoryGameTheme {
    var title: String
    var content: [String]
    var numberOfPairs: Int
    var rgb: RGB
    
    // Default theme to always init when the button is tapped
    static let defaultTheme: MemoryGameTheme = MemoryGameTheme(title: "Memory Game", content: ["😀", "😇", "😂"], numberOfPairs: 3, rgb: RGB(green: 0, red: 0, blue: 0))
}

