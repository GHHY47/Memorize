//
//  EmojiMemoryGame.swift
//  Memorize
//
//  Created by He Yan on 3/8/24.
//

import SwiftUI // View Model is part of UI

class EmojiMemoryGame: ObservableObject { //view model; Reactive UI: ObservableObject
    private static let emojis = ["🍎","🍊","🍌","🍓"] // static var and funcs, global init before
    
    private static func createMemoryGame() -> MemoryGame<String> { // static meaning like global or type function for access
        return MemoryGame(numberOfPairsOfCards: 4) { pairIndex in
            if emojis.indices.contains(pairIndex) {
                return emojis[pairIndex]
            } else {
                return "⁉️"
            }
        }
    }
        
    @Published private var model = createMemoryGame() //Reactive UI: @Published
    
    var cards: Array<MemoryGame<String>.Card> {
        return model.cards
    }
    
    // MARK: - Intents
    
    func shuffle() {
        model.shuffle()
    }
    
    func choose(_ card: MemoryGame<String>.Card) { // "_" no external name
        model.choose(card)
    }
}
