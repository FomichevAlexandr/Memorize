//
//  MemoryGame.swift
//  Memorize
//
//  Created by Александр Фомичев on 23.08.2020.
//  Copyright © 2020 Fomichev Alexander. All rights reserved.
//

import Foundation

struct MemoryGame<CardContent>{
    var cards: Array<Card>
    
    mutating func choose(card: Card){
        print("card chosen:  \(card)")
        if let chosenIndex = self.index(of: card){
            cards[chosenIndex].isFaceUp = !cards[chosenIndex].isFaceUp
        }
    }
    
    func index(of card: Card) -> Int?{
        for index in 0..<cards.count{
            if cards[index].id == card.id{
                return index
            }
        }
        return nil //TODO: Not bogus :)
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
    
    struct Card: Identifiable{
        var isFaceUp: Bool = true
        var isMatched: Bool = false
        var content: CardContent
        var id: Int
    }
}

//let names = ["Chris", "Alex", "Ewa", "Barry", "Daniella"]
//var reversedNames = names.sorted(by: { (s1: String, s2: String) -> Bool in return s1 > s2 })


