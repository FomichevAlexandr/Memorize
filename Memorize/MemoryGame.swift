//
//  MemoryGame.swift
//  Memorize
//
//  Created by Александр Фомичев on 23.08.2020.
//  Copyright © 2020 Fomichev Alexander. All rights reserved.
//

import Foundation

struct MemoryGame<CardContent> where CardContent: Equatable{
    
    struct Card: Identifiable{
        var isFaceUp: Bool = false{
            didSet {
                if isFaceUp {
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
        var seen: Bool = false
        var content: CardContent
        var id: Int
        
        //MARK: - BONUS TIME
        var bonusTimeLimit : TimeInterval = 6
        var lastFaceUpDate : Date?
        var pastFaceUpTime : TimeInterval = 0
        private var faceUpTime: TimeInterval {
            if let lastFaceUpDate = self.lastFaceUpDate {
                return pastFaceUpTime + Date().timeIntervalSince(lastFaceUpDate)
            } else {
                return pastFaceUpTime
            }
        }
        var bonusTimeRemaining: TimeInterval {
            max(0, bonusTimeLimit - faceUpTime)
        }
        var bonusRemaining: Double {
            (bonusTimeLimit > 0 && bonusTimeRemaining > 0) ? bonusTimeRemaining/bonusTimeLimit : 0
        }
        var hasEarnedBonus: Bool {
            isMatched && bonusTimeRemaining > 0
        }
        var isConsumingBonusTime: Bool{
            isFaceUp && !isMatched && bonusTimeRemaining > 0
        }
        private mutating func startUsingBonusTime(){
            if isConsumingBonusTime, lastFaceUpDate == nil {
                lastFaceUpDate = Date()
            }
        }
        private mutating func stopUsingBonusTime(){
            pastFaceUpTime = faceUpTime
            self.lastFaceUpDate = nil
        }
    }

    private(set) var cards: Array<Card>
    
    private var indexOfOneAndOnlyFaceUpCard:Int?{
        get{
            return cards.indices.filter {cards[$0].isFaceUp}.only
        }
        set{
            for index in cards.indices{
                cards[index].isFaceUp = index == newValue
            }
        }
    }
    
    var score: Int = 0
    var potentialMinusPoint: Int = 0
    
    mutating func choose(card: Card){
        if let chosenIndex = cards.firstIndex(matching: card), !cards[chosenIndex].isFaceUp, !cards[chosenIndex].isMatched{
            if let potentialMatchIndex = indexOfOneAndOnlyFaceUpCard{
                if cards[chosenIndex].content == cards[potentialMatchIndex].content{
                    cards[chosenIndex].isMatched = true
                    cards[potentialMatchIndex].isMatched = true
                    if cards[chosenIndex].hasEarnedBonus && cards[potentialMatchIndex].hasEarnedBonus{
                        score += 4
                    }else{
                        score += 2
                    }
                }else{
                    if !cards[chosenIndex].seen{
                        cards[chosenIndex].seen = true
                    }
                    else {
                        potentialMinusPoint += 1
                    }
                    score -= potentialMinusPoint
                }
                cards[chosenIndex].isFaceUp = true
                potentialMinusPoint = 0
            }else{
                indexOfOneAndOnlyFaceUpCard = chosenIndex
                if !cards[chosenIndex].seen{
                    cards[chosenIndex].seen = true
                    for index in cards.indices{
                        if cards[chosenIndex].content == cards[index].content,
                           cards[chosenIndex].id != cards[index].id,
                           cards[index].seen{
                                potentialMinusPoint = 1
                            }
                    }
                }
                else{
                    potentialMinusPoint = 1
                }
            }
        }
    }
    
    //MARK: cardContentFactory is function, that receive Int and return CardContent.
    init(numberOfPairsOfCards: Int, cardContentFactory: (Int) -> CardContent){
        cards = Array<Card>()
        for pairIndex in 0..<numberOfPairsOfCards{
            let content = cardContentFactory(pairIndex)
            cards.append(Card(content: content, id: pairIndex*2))
            cards.append(Card(content: content, id: pairIndex*2+1))
        }
        cards.shuffle()
    }
    

    
    

}




