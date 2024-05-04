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

enum Theme: Comparable, Identifiable {
    case halloween
    case vehicules
    case sports
    
    var id: Self {
        return self
    }
    
    var textName: String {
        switch self {
        case .halloween: "Halloween"
        case .vehicules: "Vehicules"
        case .sports:    "Sports"
        }
    }
    
    var iconName: String {
        switch self {
        case .halloween: "face.smiling.inverse"
        case .vehicules: "car"
        case .sports:    "figure.basketball"
        }
    }
    
    var color: Color {
        switch self {
        case .halloween : .orange
        case .vehicules : .blue
        case .sports    : .green
        }
    }
}

struct ContentView: View {
    let themes: [Theme: [String]] = [
        .halloween : ["🍭", "🎃", "👻", "🍬", "🧟", "🍫", "🧌", "🦄", "☠️"],
        .vehicules : ["✈️", "🚲", "🚕", "🚅", "🚁", "🛵" ,"🚍" ,"🚒" ,"🚜" ,"🚂" ,"🚌" ,"🚢"],
        .sports    : ["🏉", "🏐", "🏀", "⚽️", "🎾", "⚾️", "🏈", "🏓", "🏏", "🏒", "🏸"],
    ]
    
    @State var currentTheme: Theme = .halloween
    
    var body: some View {
        NavigationStack {
            VStack {
                ScrollView {
                    cards
                }
                themeButtons
            }
            .navigationTitle("Memorizar!")
        }
    }
    
    private var cards: some View {
        LazyVGrid(columns: [GridItem(.adaptive(minimum: 60))]) {
            ForEach(makeCardPairs()) { card in
                CardView(emoji: card.content)
                    .aspectRatio(2/3, contentMode: .fit)
            }
        }
        .padding()
        .foregroundColor(currentTheme.color)
    }
    
    private var themeButtons: some View {
        HStack(alignment: .firstTextBaseline, spacing: 70) {
            // Create a button for each theme
            ForEach(themes.keys.shuffled()) { theme in
                Button(action: { currentTheme = theme }) {
                    VStack {
                        Image(systemName: theme.iconName)
                            .imageScale(.large)
                        Text(theme.textName)
                            .font(.caption)
                    }
                }
            }
        }
    }
    
    private func makeCardPairs() -> [Card] {
        guard let theme = themes[currentTheme] else { return [] }
        
        let shuffledPairs = theme
            .enumerated()
            .map { (index, emoji) in
                // Creates one pair of cards with same emoji, but unique id based on the index
                [Card(id: index * 2, content: emoji), Card(id: index * 2 + 1, content: emoji)]
            }
            .joined()
            .shuffled()
            
        return shuffledPairs
    }
}


struct CardView: View {
    let emoji: String
    @State var isFaceUp: Bool = true
    
    var body: some View {
        ZStack {
            let base = RoundedRectangle(cornerRadius: 20)

            base.fill(.white)
            base.stroke(lineWidth: 2)
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
}
