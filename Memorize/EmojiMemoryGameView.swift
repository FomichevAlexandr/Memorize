//
//  EmojiMemoryGameView.swift
//  Memorize
//
//  Created by Александр Фомичев on 14.08.2020.
//  Copyright © 2020 Fomichev Alexander. All rights reserved.
//

import SwiftUI

struct EmojiMemoryGameView: View {
    @ObservedObject var viewModel: EmojiMemoryGame
    @State var  hasGameStarted:Bool = false
    var body: some View {
        if !hasGameStarted{ Button(action: {
//             EmojiMemoryGame.setTheme(numberOfTheme: Int.random(in: 0..<EmojiMemoryGame.theme.numberOfTheme))
//            EmojiMemoryGame.setTheme(numberOfTheme:5)
            hasGameStarted = true
        }, label: {
            Text("START GAME").font(Font.largeTitle.italic()).foregroundColor(Color.black)
        })}
        else{
            VStack{
                Text(EmojiMemoryGame.theme.name)
                    .font(Font.largeTitle)
                    .foregroundColor(EmojiMemoryGame.theme.color)
            
                Grid(viewModel.cards){ card in
                    CardView(card: card)
                        .onTapGesture {self.viewModel.choose(card: card)}
                        .padding(4)
                }
                    .padding()
                .foregroundColor(EmojiMemoryGame.theme.color)
            }
        }
    }
  
}



struct CardView: View{
    var card: MemoryGame<String>.Card
    var body: some View{
        GeometryReader{ geometry in
            self.body(for: geometry.size)
        }
    }
    
    func body(for size: CGSize) -> some View{
        ZStack{
            if card.isFaceUp{
            RoundedRectangle(cornerRadius: cornerRaious).fill(Color.white)
            RoundedRectangle(cornerRadius: cornerRaious).stroke(lineWidth: edgeLineWidth)
            Text(card.content)
            }
            else{
                if !card.isMatched{
                    RoundedRectangle(cornerRadius: cornerRaious).fill()
                }
            }
        }
        .font(Font.system(size: fontSize(for: size)))
    }
    
    // MARK: - Drawing Constants

    let cornerRaious: CGFloat = 10.0
    let edgeLineWidth: CGFloat = 3.0
    func fontSize(for size: CGSize) -> CGFloat{
        min(size.width, size.height)*0.85
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {

        EmojiMemoryGameView(viewModel: EmojiMemoryGame())
    }
}




