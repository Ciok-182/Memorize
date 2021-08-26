//
//  MemoryGame.swift
//  Memorize
//
//  Created by Jorge Encinas on 01/07/20.
//  Copyright © 2020 Jorge Encinas. All rights reserved.
//

import Foundation

struct MemoryGame<CardContent> where CardContent: Equatable{
    private(set) var cards: Array<Card>
    
    private var indexOfTheOneAndOnlyFaceUpCard: Int? {
        get { cards.indices.filter { cards[$0].isFaceUp }.only }  //if we have 2 cards faceup will return nil
        
        set{
            for index in cards.indices { // every touch we turn every card faceDown except the chosen
                cards[index].isFaceUp = index == newValue
            }
        }
    }
    
    mutating func choose(card: Card) {
        if let chosenIndex = cards.firstIndex(matching: card), !cards[chosenIndex].isFaceUp, !cards[chosenIndex].isMatched {
            
            if let potentialMarchIndex = indexOfTheOneAndOnlyFaceUpCard { // we have one card faceup
                if cards[chosenIndex].content == cards[potentialMarchIndex].content{ // have a match
                    cards[chosenIndex].isMatched = true
                    cards[potentialMarchIndex].isMatched = true
                }
                cards[chosenIndex].isFaceUp = true
                
            } else {  //is the first card we chose
                indexOfTheOneAndOnlyFaceUpCard = chosenIndex
            }
        }
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
        var isFaceUp: Bool = false
        var isMatched: Bool = false
        var content: CardContent
        
        var id: Int
        
    }
}
