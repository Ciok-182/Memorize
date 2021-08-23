//
//  MemoryGame.swift
//  Memorize
//
//  Created by Jorge Encinas on 01/07/20.
//  Copyright © 2020 Jorge Encinas. All rights reserved.
//

import Foundation

struct MemoryGame<CardContent> where CardContent: Equatable{
    var cards: Array<Card>
    
    var indexOfTheOneAndOnlyFaceUpCard: Int? {
        get{
            var faceUpCardIndices = [Int]()
            
            for index in cards.indices{
                if cards[index].isFaceUp{
                    faceUpCardIndices.append(index)
                }
            }
            
            if faceUpCardIndices.count == 1{
                return faceUpCardIndices.first
            } else {
                return nil
            }
            
        }
        
        set{
            for index in cards.indices{
                if index == newValue{
                    cards[index].isFaceUp = true
                } else{
                    cards[index].isFaceUp = false
                }
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
                
            } else {
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
