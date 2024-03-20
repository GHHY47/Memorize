//
//  MemorizeApp.swift
//  Memorize
//
//  Created by He Yan on 2/24/24.
//

import SwiftUI

@main
struct MemorizeApp: App {
    @StateObject var game = EmojiMemoryGame() // Reactive UI: @StateObject
    
    var body: some Scene {
        WindowGroup {
            EmojiMemoryGameView(viewModel: game)
        }
    }
}
