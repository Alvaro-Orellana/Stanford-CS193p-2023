//
//  Memorize2024App.swift
//  Memorize2024
//
//  Created by Alvaro Orellana on 27-04-24.
//

import SwiftUI

@main
struct Memorize2024App: App {
    
    @StateObject var game = EmojiMemoryGame()
    
    var body: some Scene {
        WindowGroup {
            ContentView(viewModel: game)
        }
    }
}
