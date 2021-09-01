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
        var isFaceUp: Bool = false {
            didSet{
                if isFaceUp{
                    startUsingBonusTime()
                } else {
                    stopUsingBonusTime()
                }
            }
        }
        
        var isMatched: Bool = false {
            didSet{
                stopUsingBonusTime()
            }
        }
        var content: CardContent
        
        var id: Int
        
        
        
        
        
        
        // MARK: - Bonus Time
        
        //can be zero which means "no bonus available" for this card
        var bonusTimeLimit: TimeInterval = 6
        
        //how long this card ever been face up
        private var faceUpTime: TimeInterval{
            if let lastFaceUpDate = self.lastFaceUpDate{
                return pastFaceUpTime + Date().timeIntervalSince(lastFaceUpDate)
            } else {
                return pastFaceUpTime
            }
        }
        
        // The last time this card was turned face up (and is still face up)
        var lastFaceUpDate: Date?
        //the accumulated time this card has been face up in the past
        
        var pastFaceUpTime: TimeInterval = 0
        
        //how much time left before the bonus opportunity runs out
        var bonusTimeRemaining: TimeInterval{
            max(0, bonusTimeLimit - faceUpTime)
        }
        
        var bonusRemaining: Double {
            (bonusTimeLimit > 0 && bonusTimeRemaining > 0) ? bonusTimeRemaining/bonusTimeLimit : 0
        }
        
        //whether the card was matched during the bonus time period
        var hasEarnedBonus: Bool{
            isMatched && bonusTimeRemaining > 0
        }
        
        var isConsumingBonusTime: Bool {
            isFaceUp && !isMatched && bonusTimeRemaining > 0
        }
        
        //called when the card transition to face up state
        private mutating func startUsingBonusTime(){
            if isConsumingBonusTime, lastFaceUpDate == nil{
                lastFaceUpDate = Date()
            }
        }
        
        private mutating func stopUsingBonusTime(){
            pastFaceUpTime = faceUpTime
            lastFaceUpDate = nil
        }
        
    }
    
    
    
    
    
    
    
}
