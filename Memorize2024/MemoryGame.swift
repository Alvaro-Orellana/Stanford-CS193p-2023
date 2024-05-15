//
//  MemoryGame.swift
//  Memorize2024
//
//  Created by Alvaro Orellana on 04-05-24.
//

import Foundation

struct MemoryGame<CardContent> where CardContent: Equatable {
    
    private(set) var cards: [Card]
    private var previouslySeenCards: [Card.ID]
    private(set) var score: Int
    private var dateFirstCardWasChosen: Date
    
    init(numberOfPairsOfCards: Int, cardContentGenerator: (Int) -> CardContent) {
        cards = []
        previouslySeenCards = []
        score = 0
        dateFirstCardWasChosen = .now
        
        for pairIndex in 0..<max(2, numberOfPairsOfCards) {
            let cardContent = cardContentGenerator(pairIndex)
            cards.append(Card(id: "\(pairIndex+1)a", content: cardContent))
            cards.append(Card(id: "\(pairIndex+1)b", content: cardContent))
        }
        cards.shuffle()
    }
    
    private var indexOfOneAndOnlyFaceUpCard: Int? {
        get { cards.indices.filter { cards[$0].isFaceUp }.onlyOne }
        
        set {
            // Turn all cards face down except the new setted index
            for index in cards.indices {
                if cards[index].isFaceUp  {
                    previouslySeenCards.append(cards[index].id)
                    cards[index].isFaceUp = false
                }
            }
            if let newValue {
                cards[newValue].isFaceUp = true
            }
        }
    }
    
    
    mutating func choose(_ card: Card) {
        // The index of the chosen card should always be in the cards array. Ignore a card if it's matched or face up
        guard
            let chosenCardIndex = cards.firstIndex(where: { $0.id == card.id }),
            !cards[chosenCardIndex].isMathched,
            !cards[chosenCardIndex].isFaceUp
        else { return }
        
        
        // Check if there one and only one card face up
        if let potencialMatchIndex = indexOfOneAndOnlyFaceUpCard {
            cards[chosenCardIndex].isFaceUp = true
            
            checkIfCardsMatch(card1Index: potencialMatchIndex, card2Index: chosenCardIndex)
        } else {
            // Either two cards were face up or all cards were face down
            indexOfOneAndOnlyFaceUpCard = chosenCardIndex
            dateFirstCardWasChosen = .now
        }
    }
    
    private mutating func checkIfCardsMatch(card1Index: Int, card2Index: Int) {
        
        if cards[card1Index].content == cards[card2Index].content {
            cards[card1Index].isMathched = true
            cards[card2Index].isMathched = true

            let secondsPassed = Date().timeIntervalSince(dateFirstCardWasChosen)
            score += 200 - Int(secondsPassed) * 20
            
        } else {
            // Cards did not match. Decrement score if they were already seen
            if let card1Id = previouslySeenCards.first(where: { $0 == cards[card1Index].id }),
               previouslySeenCards.contains(card1Id) {
                score -= 100
            }
            
            if let card2Id = previouslySeenCards.first(where: { $0 == cards[card2Index].id }),
               previouslySeenCards.contains(card2Id) {
                score -= 100
            }
        }
    }
    
    mutating func shuffleCards() {
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
