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
    
    //MARK: played with closure. Was: emojis[$0]
    static func createMemoryGame() -> MemoryGame<String>{
        let emojis = ["👻", "🎃", "👽","👹","💩"]
//         Int.random(in: 2...5)
        return MemoryGame<String>(numberOfPairsOfCards:3)
        { pairIndex in
            return emojis[pairIndex]}
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
