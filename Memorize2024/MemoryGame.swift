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
            cards.append(Card(id: pairIndex * 2, content: cardContent))
            cards.append(Card(id: pairIndex * 2 + 1, content: cardContent))
        }
//        cards.shuffle()
    }
    
    var indexOfOneAndOnlyFaceUpCard: Int? {
        get {
            var faceUpCount = cards.filter({ $0.isFaceUp }).count
            if faceUpCount != 1 {
                return nil
            } else {
                return cards.firstIndex(where: { $0.isFaceUp })
            }
        }
        set {
            for index in cards.indices {
                cards[index].isFaceUp = index == newValue
            }
        }
    }
    
    
    mutating func choose(_ card: Card) {
        guard let chosenCardIndex = cards.firstIndex(where: { $0.id == card.id }) else { return }
        
        if !cards[chosenCardIndex].isMathched && !cards[chosenCardIndex].isFaceUp {
            
            if let potencialMatchIndex = indexOfOneAndOnlyFaceUpCard {
                // Only one card was face up
                cards[chosenCardIndex].isFaceUp = true
                
                if cards[potencialMatchIndex].content == cards[chosenCardIndex].content {
                    cards[potencialMatchIndex].isMathched = true
                    cards[chosenCardIndex].isMathched = true
                    indexOfOneAndOnlyFaceUpCard = nil
                } else {
                    //                indexOfOneAndOnlyFaceUpCard = nil
                    //                cards[faceUpCardIndex].isFaceUp = true
                }
            } else {
                // Either two cards were face up or all cards were face down
                indexOfOneAndOnlyFaceUpCard = chosenCardIndex
            }
        }
    }
    
    mutating func shuffle() {
        cards.shuffle()
    }
    
    
    struct Card: Identifiable, Equatable {
        let id: Int
        let content: CardContent
        var isFaceUp = false
        var isMathched = false
    }
}
