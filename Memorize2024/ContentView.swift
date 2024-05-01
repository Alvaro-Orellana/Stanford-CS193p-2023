//
//  ContentView.swift
//  Memorize2024
//
//  Created by Alvaro Orellana on 27-04-24.
//

import SwiftUI

struct ContentView: View {
    
    let emojis = ["🍭", "🎃", "💀", "👻", "🍬", "🧟", "🍫", "🧌", "🦄", "🍑", "🥹", "☠️"]
    @State var numberOfCards = 10
    
    var body: some View {
        VStack {
            ScrollView {
                cards
            }
            cardCountAdjusters
        }
        .padding()

    }
    
    var cards: some View {
        LazyVGrid(columns: [GridItem(.adaptive(minimum: 60))]) {
            ForEach(0..<numberOfCards, id: \.self) { index in
                CardView(emoji: emojis[index])
                    .aspectRatio(2/3, contentMode: .fit)
            }
        }
        .padding()
        .foregroundColor(.orange)
    }
    
    var cardCountAdjusters: some View {
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
}


struct CardView: View {
    let emoji: String
    @State var isFaceUp: Bool = true
    
    
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
