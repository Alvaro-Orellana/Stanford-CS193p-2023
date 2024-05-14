//
//  EmojiMemoryGame.swift
//  Memorize2024
//
//  Created by Alvaro Orellana on 04-05-24.
//

import SwiftUI

class EmojiMemoryGame: ObservableObject {
        
    private static let themes = [
        Theme(
            name: "Sports",
            emoji: ["🏉", "🏐", "🏀", "⚽️", "🎾", "⚾️", "🏈", "🏓", "🏏", "🏒", "🏸" ,"🥏"],
            numberOfPairs: 5,
            color: .blue
        ),
        Theme(
            name: "Halloween",
            emoji: ["💀", "👻", "🎃", "🍬", "🕷️", "🕸️", "😱", "🙀", "😈", "👹"],
            numberOfPairs: 7,
            color: .orange
        ),
        Theme(
            name: "Vehicules",
            emoji: ["✈️", "🚕", "🚍", "🚅", "🚁", "🚑", "🚜", "🚂", "🚒", "🏎️", "🏸", "⛴️" ,"🚛"],
            numberOfPairs: 13,
            color: .yellow
        )
    ]
    
    init() {
        let randomTheme = Self.themes.randomElement()!
        self.currentTheme = randomTheme
        self.model = Self.createNewGame(using: randomTheme)
    }
    
    private static func createNewGame(using theme: Theme) -> MemoryGame<String> {
        var emojis = theme.emoji
        return MemoryGame(numberOfPairsOfCards: theme.numberOfPairs) { emojiIndex in
            if !emojis.isEmpty {
                emojis.removeFirst()
            } else {
                "⁉️"
            }
        }
    }

    @Published
    private var model: MemoryGame<String>
    private var currentTheme: Theme
    
    var cards: [MemoryGame<String>.Card] {
        model.cards
    }
    
    var title: String {
        currentTheme.name
    }
    
    var color: Color {
        currentTheme.color
    }
    
    var score: Int {
        model.score
    }
        
    
    // MARK: - Intents
    
    func choose(_ card : MemoryGame<String>.Card) {
        model.choose(card)
    }
    
    func shuffle() {
        model.shuffleCards()
    }
    
    func newGame() {
        let randomTheme = Self.themes.randomElement()!
        self.currentTheme = randomTheme
        self.model = Self.createNewGame(using: randomTheme)
    }
    
    struct Theme {
        let name: String
        let emoji: Set<String>
        let numberOfPairs: Int
        let color: Color
    }
}


