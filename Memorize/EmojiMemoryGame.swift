//
//  EmojiMemoryGame.swift
//  Memorize
//
//  Created by Александр Фомичев on 24.08.2020.
//  Copyright © 2020 Fomichev Alexander. All rights reserved.
//

import SwiftUI


class EmojiMemoryGame: ObservableObject{
    @Published private var model: MemoryGame<String> = EmojiMemoryGame.createMemoryGame()
    
    //MARK: played with closure. Was: pairIndex in return emojis[pairIndex]
    static func createMemoryGame() -> MemoryGame<String>{
        let emojis = ["👻", "🎃", "👽","👹","💩"]
        return MemoryGame<String>(numberOfPairsOfCards: Int.random(in: 2...5))
        { emojis[$0]
        }
    }
    //MARK: - Access to the Model
    
    var cards: Array<MemoryGame<String>.Card>{
        model.cards
    }
    
    //MARK: - Intent(s)
    func choose(card: MemoryGame<String>.Card){
        model.choose(card: card)
    }
}


struct EmojiMemoryGame_Previews: PreviewProvider {
    static var previews: some View {
        /*@START_MENU_TOKEN@*/Text("Hello, World!")/*@END_MENU_TOKEN@*/
    }
}
