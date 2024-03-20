//
//  MemorizeGame.swift
//  Memorize
//
//  Created by He Yan on 3/8/24.
//

import Foundation

struct MemoryGame<CardContent> { //model // HY-QA: what is this CardContent
    private(set) var cards: Array<Card> // access control: setting this variable is private, view is ok
    
    init(numberOfPairsOfCards: Int, cardContentFactory: (Int) -> CardContent) { //functions as types, function programming, pass func always
        cards = [] // empty array
        // add numberOfPairsOfCards x 2 cards
        for pairIndex in 0..<max(2, numberOfPairsOfCards) { // for "control variable" in "iterable thing"
            let content: CardContent = cardContentFactory(pairIndex)
            cards.append(Card(content: content))
            cards.append(Card(content: content))
        }
    }
    
    func choose(_ card: Card) {
        
    }
    
    mutating func shuffle() {
        cards.shuffle()
        print(cards)
    }
    
    struct Card { // MemoryGame.Card
        var isFaceUp = true // default value
        var isMatched = false // default value
        let content: CardContent
    }
    
}
