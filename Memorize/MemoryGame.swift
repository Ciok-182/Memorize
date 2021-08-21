//
//  MemoryGame.swift
//  Memorize
//
//  Created by Jorge Encinas on 01/07/20.
//  Copyright © 2020 Jorge Encinas. All rights reserved.
//

import Foundation

struct MemoryGame<CardContent> {
    var cards: Array<Card>
    
    mutating func choose(card: Card) {
        print("card chosen: \(card)")
        let chosenIndex: Int = cards.firstIndex(matching: card)
        cards[chosenIndex].isFaceUp = !cards[chosenIndex].isFaceUp
    }
    
    
    init(numberOfPairsOfCards: Int, cardContentFactory: (Int) -> CardContent) {
        cards = Array<Card>()
        
        for parIndex in 0..<numberOfPairsOfCards {
            let content = cardContentFactory(parIndex)
            cards.append(Card(content: content, id: parIndex*2))
            cards.append(Card(content: content, id: parIndex*2+1))
            
        }
        cards.shuffle()
    }
    
    struct Card: Identifiable {
        var isFaceUp: Bool = true
        var isMatched: Bool = false
        var content: CardContent
        
        var id: Int
        
    }
}
