//
//  ContentView.swift
//  Memorize2024
//
//  Created by Alvaro Orellana on 27-04-24.
//

import SwiftUI

struct ContentView: View {
    
    let emojis = ["🍭", "🎃", "💀", "👻", "🍬", "🧟", "🍫"]
    
    var body: some View {
        ForEach(emojis, id: \.self) { emoji in
            CardView(emoji: emoji, isFaceUp: true)
        }
    }
}


struct CardView: View {
    
    let emoji: String
    var isFaceUp: Bool
    
    var body: some View {
        
        let base = RoundedRectangle(cornerRadius: 30)
        ZStack {
            base
                .stroke(lineWidth: 10)
                .foregroundColor(.orange)
            
            Text(emoji).font(.title)
           // base.foregroundColor(.white)
        }
    }
}

#Preview {
    ContentView()
}
