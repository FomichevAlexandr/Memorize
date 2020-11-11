//
//  MemoryGame.swift
//  Memorize
//
//  Created by Александр Фомичев on 23.08.2020.
//  Copyright © 2020 Fomichev Alexander. All rights reserved.
//

import Foundation

struct MemoryGame<CardContent>{
    
    struct Card: Identifiable{
        var isFaceUp: Bool = true
        var isMatched: Bool = false
        var content: CardContent
        var id: Int
    }
    
    var cards: Array<Card>
    
    mutating func choose(card: Card){
        print("card chosen:  \(card)")
        let chosenIndex = cards.firstIndex(matching: card)
        cards[chosenIndex].isFaceUp = !cards[chosenIndex].isFaceUp
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




