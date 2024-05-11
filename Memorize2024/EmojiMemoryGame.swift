//
//  EmojiMemoryGame.swift
//  Memorize2024
//
//  Created by Alvaro Orellana on 04-05-24.
//

import SwiftUI

class EmojiMemoryGame: ObservableObject {
    
    typealias Card = MemoryGame<String>.Card
    private static let emojis = ["🏉", "🏐", "🏀", "⚽️", "🎾", "⚾️", "🏈", "🏓", "🏏", "🏒", "🏸" ,"🥏"]
    
    @Published
    private var model = MemoryGame(numberOfPairsOfCards: 10) { emojiIndex in
        if emojis.indices.contains(emojiIndex) {
            emojis[emojiIndex]

        } else {
            // Index out of bounds!
            "⁉️"
        }
    }
    
    var cards: Array<Card> {
        model.cards
    }
    
    // MARK: - Intents
    
    func choose(_ card : Card) {
        model.choose(card)
    }
    
    func shuffle() {
        model.shuffle()
    }
}
