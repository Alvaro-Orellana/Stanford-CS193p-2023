//
//  MemoryGame.swift
//  Memorize2024
//
//  Created by Alvaro Orellana on 04-05-24.
//

import Foundation

struct MemoryGame<CardContent> where CardContent: Equatable {
    private(set) var cards: [Card]
    
    init(numberOfPairsOfCards: Int, cardContentGenerator: (Int) -> CardContent) {
        cards = []
        for pairIndex in 0..<numberOfPairsOfCards {
            let cardContent = cardContentGenerator(pairIndex)
            cards.append(Card(id: "\(pairIndex+1)a", content: cardContent))
            cards.append(Card(id: "\(pairIndex+1)b", content: cardContent))
        }
        cards.shuffle()
    }
    
    var indexOfOneAndOnlyFaceUpCard: Int? {
        get { cards.indices.filter { cards[$0].isFaceUp }.onlyOne }
        
        // Turn all cards face down except the new setted index
        set { cards.indices.forEach { cards[$0].isFaceUp = $0 == newValue }}
    }
    
    
    mutating func choose(_ card: Card) {
        // The index of the chosen card should always be in the cards array. Ignore a card if is matched or face up
        guard
            let chosenCardIndex = cards.firstIndex(where: { $0.id == card.id }),
            !cards[chosenCardIndex].isMathched,
            !cards[chosenCardIndex].isFaceUp
        else { return }
        
        
        // Check if there one and only one card face up
        if let potencialMatchIndex = indexOfOneAndOnlyFaceUpCard {
            
            if cards[potencialMatchIndex].content == cards[chosenCardIndex].content {
                cards[potencialMatchIndex].isMathched = true
                cards[chosenCardIndex].isMathched = true
            }
            cards[chosenCardIndex].isFaceUp = true
        } else {
            // Either two cards were face up or all cards were face down
            indexOfOneAndOnlyFaceUpCard = chosenCardIndex
        }
    }
    
    mutating func shuffle() {
        cards.shuffle()
    }
    
    
    struct Card: Identifiable, Equatable {
        let id: String
        let content: CardContent
        var isFaceUp = false
        var isMathched = false
    }
}


extension Array {
    var onlyOne: Element? {
        count == 1 ? first : nil
    }
}
