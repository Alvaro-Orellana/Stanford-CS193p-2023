//
//  ContentView.swift
//  Memorize2024
//
//  Created by Alvaro Orellana on 27-04-24.
//

import SwiftUI

struct ContentView: View {
   
    @ObservedObject var viewModel: EmojiMemoryGame
    
    var body: some View {
        VStack {
            ScrollView {
                cards
            }
            .padding(5)
            
            Button("Shuffle") {
                viewModel.shuffle()
            }
        }
        .navigationTitle("Memorize!")
    }
    
    private var cards: some View {
        LazyVGrid(columns: [GridItem(.adaptive(minimum: 70), spacing: 0)], spacing: 0) {
            ForEach(viewModel.cards) { card in
                CardView(card)
                    .aspectRatio(2/3, contentMode: .fit)
                    .padding(5)
                    .animation(.easeIn, value: viewModel.cards)
                    .opacity(card.isMathched ? 0 : 1)
                    .onTapGesture {
                        viewModel.choose(card)
                    }
            }
        }
        .foregroundColor(.orange)
    }
}


struct CardView: View {
    
    let card: MemoryGame<String>.Card
    
    init(_ card: MemoryGame<String>.Card) {
        self.card = card
    }
    
    var body: some View {
        ZStack {
            let base = RoundedRectangle(cornerRadius: 20)

            base.fill(.white)
            base.stroke(lineWidth: 2)
            Text(card.content)
                .font(.system(size: 100))
                .minimumScaleFactor(0.01)
                .aspectRatio(1, contentMode: .fit)
            
            base.opacity(card.isFaceUp ? 0 : 1)
        }
    }
}

#Preview {
    ContentView(viewModel: EmojiMemoryGame())
    
//    CardView(MemoryGame.Card(id: 1, content: "w"))
}


