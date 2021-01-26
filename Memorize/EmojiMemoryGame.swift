//
//  EmojiMemoryGame.swift
//  Memorize
//
//  Created by Александр Фомичев on 24.08.2020.
//  Copyright © 2020 Fomichev Alexander. All rights reserved.
//

import SwiftUI

//extension EmojiMemoryGame.Theme: Equatable{
//    static func == (lhs: EmojiMemoryGame.Theme, rhs: EmojiMemoryGame.Theme) -> Bool {
//        return lhs.name == rhs.name &&
//            lhs.emojiSet == rhs.emojiSet &&
//            lhs.color == rhs.color &&
//            lhs.numberOfCard == rhs.numberOfCard
//    }
//}

class EmojiMemoryGame: ObservableObject{
    
    @Published private var model: MemoryGame<String> = EmojiMemoryGame.createMemoryGame()
    
    private static let themes = [("Hallowen",["👻", "🎃", "👽","👹","💀"], Color.orange),
                 ("Faces",["🤩","🤑","🤠","😤","😎"],Color.yellow),
                 ("Cats",["😻","😿","😹","😽","🙀"], Color.blue),
                 ("Hands",["👊","🙏","🤙","💪","🖕"], Color.black),
                 ("Animals",["🐱","🐰","🐻","🐼","🐨"],Color.green),
                 ("Cars",["🚗","🚕","🏎", "🚓", "🛵"],Color.red)]
    
    //MARK: Can: emojiSet[$0]
    private static func createMemoryGame() -> MemoryGame<String>{
        setTheme(numberOfTheme: Int.random(in: 0...themes.count-1))
        return MemoryGame<String>(numberOfPairsOfCards: theme.numberOfCard)
        { pairIndex in
            return theme.emojiSet[pairIndex]}
    }
    
    static func setTheme(numberOfTheme: Int){
        theme = Theme(name:themes[numberOfTheme].0, emojiSet: themes[numberOfTheme].1, color: themes[numberOfTheme].2)
    }
    
    static var theme: Theme = Theme(name:themes[0].0, emojiSet: themes[0].1, color: themes[0].2)

    struct Theme{
        let numberOfTheme = themes.count
        let name: String
        let emojiSet: [String]
        var numberOfCard: Int{
            get{
                Int.random(in: 2...emojiSet.count)
            }
        }
        let color: Color
    }
    
    var score: Int{
        model.score
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
