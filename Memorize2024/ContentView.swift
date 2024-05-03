//
//  ContentView.swift
//  Memorize2024
//
//  Created by Alvaro Orellana on 27-04-24.
//

import SwiftUI

struct Card: Identifiable {
    let id: Int
    let content: String
}


struct ContentView: View {
    let themes = [
        "Halloween" : ["🍭", "🎃", "👻", "🍬", "🧟", "🍫", "🧌", "🦄", "🍑", "☠️"],
        "Vehicules" : ["✈️", "🚲", "🚕", "🚅", "🚁", "🛵" ,"🚍" ,"🚒" ,"🚜" ,"🚂" ,"🚌" ,"🚢"],
        "Sports"    : ["🏉", "🏐", "🏀", "⚽️", "🎾", "⚾️", "🏈", "🏓", "🏏", "🏒", "🏸" ,"🥏" ],
    ]
    
    //@State var numberOfCards = 10
    @State var currentTheme = "Halloween"
    let cardsColor: Color = .pink
    
    var body: some View {
        VStack {
            ScrollView {
                cards
            }
            themeButtons
        }
        .navigationTitle("Memorize!")
    }
    
    private var cards: some View {
        LazyVGrid(columns: [GridItem(.adaptive(minimum: 60))]) {
            
            let cards = makePairs(from: currentTheme)
            ForEach(cards) { card in
                CardView(emoji: card.content)
                    .aspectRatio(2/3, contentMode: .fit)
            }
        }
        .padding()
        .foregroundColor(cardsColor)
    }
    
    private var themeButtons: some View {
        HStack(spacing: 70) {
            ForEach(themes.keys.sorted(), id: \.self) { theme in
                Button(action: { currentTheme = theme }) {
                    VStack {
                        Image(systemName: getIconName(for: theme))
                            .font(.title2)
                        Text(theme)
                            .font(.caption)
                    }
                }
            }
        }
    }
    
    private func makePairs(from theme: String) -> [Card] {
        themes[currentTheme]!
            .enumerated()
            .map { (index, emoji) in
                [Card(id: index * 2, content: emoji), Card(id: index * 2 + 1, content: emoji)]
            }
            .joined()
            .shuffled()
        
//        var cards: [Card] = []
//        
//        for (index, emoji) in themes[currentTheme]!.enumerated() {
//            cards += [Card(id: index * 2, content: emoji), Card(id: index * 2 + 1, content: emoji)]
//        }
//        return cards.shuffled()
    }
    
    private func getIconName(for theme: String) -> String {
        switch theme {
        case "Halloween": "face.smiling.inverse"
        case "Vehicules": "car"
        case "Sports"   : "figure.basketball"
        default         : "questionmark.circle"
        }
    }
    
    /*
    private var cardCountAdjusters: some View {
        HStack {
            cardDecreaseButton
            Spacer()
            cardIncreaseButton
        }
        .imageScale(.large)
        .font(.largeTitle)
    }
    
    private var cardIncreaseButton: some View {
        cardAdjuster(by: +1, imageName: "rectangle.stack.fill.badge.plus")

    }
    
    private var cardDecreaseButton: some View {
        cardAdjuster(by: -1, imageName: "rectangle.stack.fill.badge.minus")

    }
    
    private func cardAdjuster(by offset: Int, imageName: String) -> some View {
        Button(action: { numberOfCards += offset }) {
            Image(systemName: imageName)
        }
        .disabled(numberOfCards + offset < 0 || numberOfCards + offset > emojis.count)
    }
     */
}


struct CardView: View {
    let emoji: String
    @State var isFaceUp: Bool = false
    
    
    var body: some View {
        ZStack {
            let base = RoundedRectangle(cornerRadius: 20)

            base.fill(.white)
            base.stroke(lineWidth: 3)
            Text(emoji).font(.largeTitle)
            base.opacity(isFaceUp ? 0 : 1)
        }
        .onTapGesture {
            isFaceUp.toggle()
        }
    }
    
}

#Preview {
    ContentView()
    //CardView(emoji: "👁️", isFaceUp: true)
}
